require 'spec_helper'

describe Lisp::Evaluator do
  subject { described_class.new }

  describe "#lisp_eval" do
    let(:env) { double('env') }

    context "when the variable is a Symbol" do
      it "finds it in the environment" do
        sym = :sym
        expect(env).to receive(:find).with(sym).and_return({})
        subject.lisp_eval(sym, env)
      end
    end

    context "when the variable is not an array" do
      it "returns the value" do
        v = 23
        expect(subject.lisp_eval(v, env)).to eq(v)
      end
    end

    context "when the array has 'quote' as the first element" do
      it "returns the rest of the array" do
        a = [:quote, :a, :b, :c]
        expect(subject.lisp_eval(a, env)).to eq([:a, :b, :c])
      end
    end

    context "when the value is :exit" do
      it "returns exit" do
        expect(subject.lisp_eval([:exit], env)).to eq(:exit)
      end
    end 

    context "when the value is :quit" do
      it "returns exit" do
        expect(subject.lisp_eval([:quit], env)).to eq(:exit)
      end
    end

    context "when the first element is lambda" do
      let(:procedure) { [:lambda, :parms, :body] }

      it "creates a new Procedure" do
        expect(Lisp::Procedure).to receive(:new).with(subject, :parms, :body, env)
        subject.lisp_eval(procedure, env)
      end
    end
  end
end
