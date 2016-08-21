require 'spec_helper'

describe Lisp::Tokenizer do
  let(:input) { StringIO.new("(+ 3 4)") }
  let(:tokenizer) { described_class.new(input) }

  describe "#read_s_expr" do
    it "converts an s expession to an array of tokens" do
      expect(tokenizer.read_s_expr).to eq(["(", "+", "3", "4", ")"])
    end

    context "when there are comments" do
      let(:input) { StringIO.new("(+ 3 ; removes this\n 4) ; and this") }
      it "removes them" do
        expect(tokenizer.read_s_expr).to eq(["(", "+", "3", "4", ")"])
      end
    end
  end
end
