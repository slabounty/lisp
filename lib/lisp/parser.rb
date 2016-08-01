module Lisp
  class Parser
    class LispSyntaxError < StandardError; end

    def parse(program)
      # "Read a Scheme expression from a string."
      read_from_tokens(tokenize(program))
    end

    def tokenize(program)
      program.gsub('(', ' ( ').gsub(')', ' ) ').split()
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
  end
end

