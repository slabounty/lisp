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
        result = subject.read_from_tokens(['(', 'foo', 'bar', ')'])
        expect(result).to eq([:foo, :bar])
      end
    end

    context "when the tokens start with a ')'" do
      it "raises a lisp syntax exception" do
        expect { subject.read_from_tokens([')', 'hello', 'world']) }.to raise_exception Lisp::Parser::LispSyntaxError
      end
    end

    context "when the token is a something else" do
      it "returns the token as an 'atom'" do
        expect(subject).to receive(:atom).and_call_original
        subject.read_from_tokens(['hello'])
      end
    end
  end

  describe "#atom" do
    context "when the token is a quoted string" do
      it "returns the string" do
        expect(subject.atom('"hello"')).to eq("hello")
      end
    end

    context "when the token is a quoted string has spaces" do
      it "returns the string" do
        expect(subject.atom('"hello world"')).to eq("hello world")
      end
    end

    context "when the token is an integer" do
      it "returns the integer" do
        expect(subject.atom("-42")).to eq(-42)
      end
    end

    context "when the token is a float" do
      it "returns the float" do
        expect(subject.atom('42.0')).to eq(42.0)
      end
    end

    context "when the token is anything else" do
      it "returns the token as a symbol" do
        expect(subject.atom('hello')).to eq(:hello)
      end
    end
  end
end
