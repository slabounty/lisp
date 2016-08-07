require 'spec_helper'

describe Lisp do
  let(:parser) { Lisp::Parser.new }
  let(:evaluator) { Lisp::Evaluator.new }

  it "can creates a list" do
    string =  "(quote a b c)" 
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq([:a, :b, :c])
  end

  it "can take the car of a list" do
    string =  "(car (list 1 2 3))" 
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(1)
  end

  it "can take the cdr of a list" do
    string =  "(cdr (list 1 2 3))" 
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq([2, 3])
  end

  it "can define a value" do
    string = "(begin (define x 42) x)"
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(42)
  end

  it "can create a new list" do
    string = "(cons 10 (list))"
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq([10])
  end

  it "can tell the length of a list" do
    string = "(length (list 1 2 3 4))"
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(4)
  end

  context "when the expression is a list" do
    it "returns true" do
      string = "(list? (list 1 2 3 4))"
      tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
      expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(true)
    end
  end

  context "when the expression is not a list" do
    it "returns false" do
      string = "(list? 10)"
      tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
      expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(false)
    end
  end

  it "can take the absolute value of a number" do
    string = "(abs -10)"
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(10)
  end

  it "can get the min of a list of numbers" do
    string = "(min (list 10 3 22 5))"
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(3)
  end

  it "can get the max of a list of numbers" do
    string = "(max (list 10 3 22 5))"
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(22)
  end

  it "can add two numbers" do
    string = "(add 10 3)"
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(13)
  end

  it "can subtract two numbers" do
    string = "(subtract 10 3)"
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(7)
  end

  it "can multiply two numbers" do
    string = "(multiply 10 3)"
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(30)
  end

  it "can divide two numbers" do
    string = "(divide 10 2)"
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(5)
  end

  it "can perform an if operation" do
    string = "(if (> 3 10) \"y\" \"n\")"
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq("n")
  end

end
