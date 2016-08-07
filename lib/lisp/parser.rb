module Lisp
  class Parser
    class LispSyntaxError < StandardError; end

    def parse(tokenized_program)
      read_from_tokens(tokenized_program)
    end

    def read_from_tokens(tokens)
      # "Read an expression from a sequence of tokens."
      fail LispSyntaxError, 'unexpected EOF while reading' if tokens.length == 0

      token = tokens.shift
      case token
      when '('
        return build_list(tokens)
      when ')'
        fail LispSyntaxError, 'unexpected )'
      else
        return build_atom(token)
      end
    end

    def build_list(tokens)
      l = []
      while tokens[0] != ')'
        l << read_from_tokens(tokens)
      end
      tokens.shift # pop off ')'

      return l
    end

    def build_atom(token)
      # Stings become strings
      # Numbers become numbers; 
      # every other token is a symbol.
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

