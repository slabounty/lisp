# program = "(begin (define r 10) (* pi (* r r)))"
# parse(program)
module Lisp
  class Lisp
    def initialize(input = STDIN, output = STDOUT, prompt = "> ")
      @input = input
      @output = output
      @prompt = prompt
    end

    def repl
      parser = Parser.new
      evaluator = Evaluator.new

      begin
        print_prompt
        val = evaluator.lisp_eval(parser.parse(read_s_expr))
        output.puts schemestr(val)
      rescue => e
        output.puts "Error: #{e}"
        output.puts e.backtrace
      end while val != :exit
    end

    def print_prompt
      output.print prompt
    end

    def read_s_expr
      s_expr = ""
      paren_count = 0

      begin
        c = input.getc
        s_expr << ((c != "\n") ? c : " ")
        paren_count += 1 if c == '('
        paren_count -= 1 if c == ')'
      end while (paren_count != 0) || s_expr =~ /^\s*$/

      return s_expr
    end

    def schemestr(exp)
      if exp.is_a?(Array)
        "(#{exp.join(' ')})"
      else
        exp.to_s
      end
    end

    private

    attr_reader :input, :output, :prompt
  end
end
