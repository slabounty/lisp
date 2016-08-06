module Lisp
  class Tokenizer
    def initialize(input=STDIN)
      @input = input
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
      while tokens == []
        replinish_tokens
      end
      tokens.shift
    end

    def replinish_tokens
      tokens
        .concat(input.gets.scan(/[()]|[^ \t\r\n\f()]+/))
        .map { |t| t != "\n" ? t : " " }
    end

    def tokens
      @tokens ||= []
    end

    private

    attr_reader :input
  end
end
