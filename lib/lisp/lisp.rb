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
      begin
        print_prompt
        val = evaluator
          .lisp_eval(
            parser.parse(
              tokenizer.read_s_expr))
        output.puts schemestr(val)
      rescue => e
        output.puts "Error: #{e}"
        output.puts e.backtrace
      end while val != :exit
    end

    def parser
      @parser ||= Parser.new
    end

    def evaluator
      @evaluator ||= Evaluator.new
    end

    def tokenizer
      @tokenizer ||= Tokenizer.new(input)
    end

    def print_prompt
      output.print prompt
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
