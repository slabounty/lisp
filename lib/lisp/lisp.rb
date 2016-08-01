# program = "(begin (define r 10) (* pi (* r r)))"
# parse(program)
module Lisp
  class Lisp
    def repl(prompt = '> ')
      parser = Parser.new
      evaluator = Evaluator.new

      begin
        val = evaluator.lisp_eval(parser.parse(raw_input(prompt)))
        puts schemestr(val)
      rescue => e
        puts "Error: #{e}"
        puts e.backtrace
      end while val != :exit
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
