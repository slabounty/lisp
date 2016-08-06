require 'spec_helper'

describe Lisp::Lisp do
  subject { described_class.new(input, output, prompt) }
  let(:input) { double('input').as_null_object }
  let(:output) { double('output').as_null_object }
  let(:prompt) { ">>" }

  describe "#print_prompt" do
    before do
      allow(output).to receive(:print)
    end

    it "prints the prompt" do
      expect(output).to receive(:print).with(prompt)
      subject.print_prompt
    end
  end

  describe "#schemestr" do
    context "when the expression is an array" do
      it "prints it as a list" do
        expect(subject.schemestr(['+', 32, 44])).to eq("(+ 32 44)")
      end
    end

    context "when the expression is not an array" do
      context "when the expression is a number" do
        it "prints it as a string" do
          expect(subject.schemestr(42)).to eq("42")
        end
      end

      context "when the expression is a symbol" do
        it "prints it as a string" do
          expect(subject.schemestr(:hello)).to eq("hello")
        end
      end

      context "when the expression is a string" do
        it "prints it as a string" do
          expect(subject.schemestr("hello")).to eq("hello")
        end
      end
    end
  end
end
