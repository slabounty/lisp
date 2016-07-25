require 'spec_helper'

describe Lisp::Lisp do
  subject { described_class.new }

  describe "#tokenize" do
    let(:program) { "(begin (define r 10) (* pi (* r r)))" }
    it "tokenizes the program into an array of strings" do
      expect(subject.tokenize(program)).to eq(["(", "begin", "(", "define", "r", "10", ")", "(", "*", "pi", "(", "*", "r", "r", ")", ")", ")"])
    end
  end

  describe "#parse" do
    let(:program) { "(begin (define r 10) (* pi (* r r)))" }
    it "parses the program into an array of symbols" do
      expect(subject.parse(program)).to eq([:begin, [:define, :r, 10], [:*, :pi, [:*, :r, :r]]])
    end
  end

  describe "#read_from_tokens" do
    context "when the tokens are empty" do
      it "raises a lisp syntax exception" do
        expect { subject.read_from_tokens([]) }.to raise_exception Lisp::Lisp::LispSyntaxError
      end
    end

    context "when the token is a '('" do
      it "returns an array of symbols" do
      end
    end

    context "when the tokens start with a ')'" do
      it "raises a lisp syntax exception" do
        expect { subject.read_from_tokens([')', 'hello', 'world']) }.to raise_exception Lisp::Lisp::LispSyntaxError
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
    context "when the token is an integer" do
      it "returns the integer" do
        expect(subject.atom(-42)).to eq(-42)
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
