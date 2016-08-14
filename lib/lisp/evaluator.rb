module Lisp
  class Evaluator
    def initialize
      @global_env = Environment.standard_env
    end

    def lisp_eval(x, env = @global_env)
      # Evaluate an expression in an environment."
      if x.is_a? Symbol      # variable reference
        return env.find(x)[x]
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
      elsif x[0] == :or
        x[1..-1].each { |exp| return true if lisp_eval(exp, env) != false }; return false
      elsif x[0] == :and
        x[1..-1].each { |exp| return false if lisp_eval(exp, env) == false }; return true
      elsif x[0] == :lambda         # procedure
        parms = x[1]
        body = x[2]
        return Procedure.new(self, parms, body, env)
      else                          # (proc arg...)
        p = lisp_eval(x[0], env)
        args = x[1..-1].map { |arg| lisp_eval(arg, env) }
        return p.call(*args)
      end
    end
  end
end
