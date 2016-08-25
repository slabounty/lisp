module Lisp
  class Atom
    def self.build(token)
      return true if token.downcase == "#t"
      return false if token.downcase == "#f"

      match = /"(.*)"/.match(token)
      return match[1] if match

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
