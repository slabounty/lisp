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
      end while (paren_count != 0)

      return s_expr
    end

    def get_token
      replinish_tokens while tokens == []
      tokens.shift
    end

    def replinish_tokens
      tokens
        .concat(input
                .gets
                .sub(/;.*$/, '').scan(/[()]|"[^"]+"|[^ \t\r\n\f()]+/))
        .map { |t| t != "\n" ? t : " " }
    end

    private

    attr_reader :input, :tokens
  end
end
