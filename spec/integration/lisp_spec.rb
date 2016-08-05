require 'spec_helper'

describe Lisp do
  let(:parser) { Lisp::Parser.new }
  let(:evaluator) { Lisp::Evaluator.new }
  let(:list) { "(quote a b c)" }

  it "can creates a list" do
    expect(evaluator.lisp_eval(parser.parse("#{list}"))).to eq([:a, :b, :c])
  end

  it "can take the car of a list" do
    expect(evaluator.lisp_eval(parser.parse("(car #{list})"))).to eq(:a)
  end

  it "can take the cdr of a list" do
    expect(evaluator.lisp_eval(parser.parse("(cdr #{list})"))).to eq([:b, :c])
  end

  it "can define a value" do
    expr = "(begin (define x 42) x)"
    expect(evaluator.lisp_eval(parser.parse(expr))).to eq(42)
  end

  it "can create a new list" do
    expr = "(cons 10 (list))"
    expect(evaluator.lisp_eval(parser.parse(expr))).to eq([10])
  end

  it "can tell the length of a list" do
    expr = "(length (list 1 2 3 4))"
    expect(evaluator.lisp_eval(parser.parse(expr))).to eq(4)
  end

  context "when the expression is a list" do
    it "returns true" do
      expr = "(list? (list 1 2 3 4))"
      expect(evaluator.lisp_eval(parser.parse(expr))).to eq(true)
    end
  end

  context "when the expression is not a list" do
    it "returns false" do
      expr = "(list? 10)"
      expect(evaluator.lisp_eval(parser.parse(expr))).to eq(false)
    end
  end

  it "can take the absolute value of a number" do
    expr = "(abs -10)"
    expect(evaluator.lisp_eval(parser.parse(expr))).to eq(10)
  end

  it "can get the min of a list of numbers" do
    expr = "(min (list 10 3 22 5))"
    expect(evaluator.lisp_eval(parser.parse(expr))).to eq(3)
  end

  it "can get the max of a list of numbers" do
    expr = "(max (list 10 3 22 5))"
    expect(evaluator.lisp_eval(parser.parse(expr))).to eq(22)
  end

  it "can add two numbers" do
    expr = "(add 10 3)"
    expect(evaluator.lisp_eval(parser.parse(expr))).to eq(13)
  end

  it "can subtract two numbers" do
    expr = "(subtract 10 3)"
    expect(evaluator.lisp_eval(parser.parse(expr))).to eq(7)
  end

  it "can multiply two numbers" do
    expr = "(multiply 10 3)"
    expect(evaluator.lisp_eval(parser.parse(expr))).to eq(30)
  end

  it "can divide two numbers" do
    expr = "(divide 10 2)"
    expect(evaluator.lisp_eval(parser.parse(expr))).to eq(5)
  end
end
