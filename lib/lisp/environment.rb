module Lisp
  class Environment < Hash
    # "An environment: a dict of {'var':val} pairs, with an outer Env."
    def self.standard_env
      Environment.new.merge(
        {
          begin: lambda { |*l| l[-1] },
          car: lambda { |l| l[0] },
          cdr: lambda { |l| l[1..-1] },
          cons: lambda { |l1, l2| [l1] + l2 },
          list: lambda { |*l| l },
          list?: lambda { |l| l.is_a? Array },
          length: lambda { |l| l.length },

          abs: lambda { |x| x.abs },
          min: lambda { |l1, l2| [l1, l2].min },
          max: lambda { |l1, l2| [l1, l2].max },

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

          not: lambda { |l| !l },
          equal?: lambda { |l1, l2| l1 == l2 },
          empty?: lambda { |l| l == [] },
          null?: lambda { |l| l == [] },
        }
      )
    end

    def initialize(params=[], args=[], outer=nil)
      params.zip(args).each { |pair| self[pair[0]] = pair[1] }
      @outer = outer
    end

    def find(var)
      # Find the innermost Env where var appears."
      # return self if (var in self) else self.outer.find(var) end
      self[var] ?  self : @outer.find(var)
    end
  end
end
