module Lisp
  class Tokenizer
    def initialize(input=STDIN)
      @input = input
      @tokens = []
    end

    def read_s_expr
      s_expr = []
      paren_count = 0

      begin
        token = get_token
        s_expr << token
        paren_count += 1 if token == '('
        paren_count -= 1 if token == ')'
      end while (paren_count != 0) || token == "'"

      return s_expr
    end

    def get_token
      token = ''
      while true
        c = input.getc
        case c
        when '"' # quoted string
          token << c
          while (c = input.getc) != '"' do
            token << c
          end
          token << c
          return token
        when ';' # Comment, delete to eol
          input.gets
          return token if token != ''
        when /[()]/ # open / close paren
          if token != ''
            input.ungetc c
            return token
          else
            return c
          end
        when "'"
          return c
        when /\s/ # white space
          return token if token != ''
        when nil # eof essentially
          return token if token != ''
        else # anything else
          token << c
        end
      end
    end

    private

    attr_reader :input, :tokens
  end
end
