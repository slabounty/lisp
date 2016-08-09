require 'spec_helper'

describe Lisp::Parser do
  subject { described_class.new }

  describe "#read_from_tokens" do
    context "when the tokens are empty" do
      it "raises a lisp syntax exception" do
        expect { subject.read_from_tokens([]) }.to raise_exception Lisp::Parser::LispSyntaxError
      end
    end

    context "when the token is a '('" do
      it "returns an array of symbols" do
      end
    end

    context "when the tokens start with a ')'" do
      it "raises a lisp syntax exception" do
        expect { subject.read_from_tokens([')', 'hello', 'world']) }.to raise_exception Lisp::Parser::LispSyntaxError
      end
    end

    context "when the token is a something else" do
      it "returns the token as an 'atom'" do
        expect(Lisp::Atom).to receive(:build).and_call_original
        subject.read_from_tokens(['hello'])
      end
    end
  end
end
