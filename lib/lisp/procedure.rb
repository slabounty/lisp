module Lisp
  class Procedure
    # A user-defined Scheme procedure."
    def initialize(evaluator, parms, body, env)
      @evaluator = evaluator
      @parms = parms
      @body = body
      @env = env
    end

    def call(*args) 
      return @evaluator.lisp_eval(@body, Environment.new(@parms, args, @env))
    end
  end
end
