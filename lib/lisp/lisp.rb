# program = "(begin (define r 10) (* pi (* r r)))"
# parse(program)
module Lisp
  class Lisp
    class LispSyntaxError < StandardError; end

    def tokenize(program)
      program.gsub('(', ' ( ').gsub(')', ' ) ').split()
    end

    def parse(program)
      # "Read a Scheme expression from a string."
      read_from_tokens(tokenize(program))
    end

    def read_from_tokens(tokens)
      # "Read an expression from a sequence of tokens."
      fail LispSyntaxError, 'unexpected EOF while reading' if tokens.length == 0

      token = tokens.shift
      if '(' == token
        l = []
        while tokens[0] != ')'
          l << read_from_tokens(tokens)
        end
        tokens.shift # pop off ')'
        return l
      elsif ')' == token
        fail LispSyntaxError, 'unexpected )'
      else
        return atom(token)
      end
    end

    def atom(token)
      # Numbers become numbers; every other token is a symbol."
      begin
        return Integer(token)
      rescue
        begin
          return Float(token)
        rescue
          return token.to_sym
        end
      end
    end

    def standard_env
      @standard_env ||=
        {
          car: lambda { |l| l[0] },
          cdr: lambda { |l| l[1..-1] },
          list: lambda { |*l| l },
          list?: lambda { |l| l.is_a? Array },

          '+': lambda { |l1, l2| l1 + l2 },
          add: lambda { |l1, l2| l1 + l2 },

          multiply: lambda { |l1, l2| l1 * l2 },
          '*': lambda { |l1, l2| l1 * l2 },

          subtract: lambda { |l1, l2| l1 - l2 },
          '-': lambda { |l1, l2| l1 - l2 },

          divide: lambda { |l1, l2| l1 / l2 },
          '/': lambda { |l1, l2| l1 / l2 },

          '>': lambda { |l1, l2| l1 > l2 },
          '<': lambda { |l1, l2| l1 < l2 },
          '>=': lambda { |l1, l2| l1 >= l2 },
          '<=': lambda { |l1, l2| l1 <= l2 },
          '=': lambda { |l1, l2| l1 == l2 },
        }
    end

    def lisp_eval(x, env=standard_env)
      # Evaluate an expression in an environment."
      if x.is_a? Symbol      # variable reference
        return env.fetch(x, x)
      elsif !x.is_a? Array   # constant literal
        return x
      elsif x[0] == :quote          # (quote exp)
        return x[1..-1]
      elsif x[0] == :if             # (if test conseq alt)
        _, test, conseq, alt = x
        exp = lisp_eval(test, env) ? conseq : alt
        return lisp_eval(exp, env)
      elsif x[0] == :define         # (define var exp)
        var = x[1]
        exp = x[2]
        env[var] = lisp_eval(exp, env)
      else                          # (proc arg...)
        p = lisp_eval(x[0], env)
        args = x[1..-1].map { |arg| lisp_eval(arg, env) }
        return p.call(*args)
      end
    end

    def repl(prompt = '> ')
      while true
        val = lisp_eval(parse(raw_input(prompt)))
        puts schemestr(val)
      end
    end

    def raw_input(prompt)
      print prompt
      gets.chomp
    end

    def schemestr(exp)
      if exp.is_a?(Array)
        "(#{exp.join(' ')})"
      else
        exp.to_s
      end
    end
  end
end
