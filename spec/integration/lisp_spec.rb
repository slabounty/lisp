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

  it "can add two numbers" do
    string = "(+ 10 3)"
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(13)
  end

  it "can subtract two numbers" do
    string = "(subtract 10 3)"
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(7)
  end

  it "can subtract two numbers" do
    string = "(- 10 3)"
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(7)
  end

  it "can multiply two numbers" do
    string = "(multiply 10 3)"
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(30)
  end

  it "can multiply two numbers" do
    string = "(* 10 3)"
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(30)
  end

  it "can divide two numbers" do
    string = "(divide 10 2)"
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(5)
  end

  it "can divide two numbers" do
    string = "(/ 10 2)"
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(5)
  end

  it "can perform an > operation" do
    string = "(> 3 10)"
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(false)
  end

  it "can perform an < operation" do
    string = "(< 3 10)"
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(true)
  end

  it "can perform an >= operation" do
    string = "(>= 3 3)"
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(true)
  end

  it "can perform an <= operation" do
    string = "(<= 3 10)"
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(true)
  end

  it "can perform an = operation" do
    string = "(= 3 10)"
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(false)
  end

  context "when a list is not empty" do
    it "empty? returns false" do
      string = "(empty? (list 3 10))"
      tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
      expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(false)
    end
  end

  context "when a list is empty" do
    it "empty? returns true" do
      string = "(empty? (list))"
      tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
      expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(true)
    end
  end

  context "when a list is not null" do
    it "null? returns false" do
      string = "(null? (list 3 10))"
      tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
      expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(false)
    end
  end

  context "when a list is null" do
    it "null? returns true" do
      string = "(null? (list))"
      tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
      expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(true)
    end
  end

  context "when a list is not equal" do
    it "equal? returns false" do
      string = "(equal? (list 3 10) (list 10 3))"
      tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
      expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(false)
    end
  end

  context "when a list is equal" do
    it "equal? returns true" do
      string = "(equal? (list 3 10) (list 3 10))"
      tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
      expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(true)
    end
  end

  it "handles true" do
    string = "#t"
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(true)
  end

  it "handles false" do
    string = "#f"
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(false)
  end

  it "can perform an if operation" do
    string = "(if (> 3 10) \"y\" \"n\")"
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq("n")
  end

  it "can perform a map operation" do
    string = "(map (lambda(x) (+ x 1)) (list 5 6 7))"
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq([6, 7, 8])
  end

  it "can perform a map operation" do
    string = "(map add (list 2 3 4) (list 5 6 7))"
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq([7, 9, 11])
  end

  context "or operation" do
    context "when the or is true" do
      it "returns true" do
        string = "(or (= 2 2) (< 2 1))"
        tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
        expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(true)
      end
    end

    context "when the or is false" do
      it "returns false" do
        string = "(or (< 3 2) (< 2 1))"
        tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
        expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(false)
      end
    end
  end

  context "cond statement" do
    context "when the first conditional is true" do
      it "returns the first expression" do
        string =
          "(cond ((> 3 1) \"greater\")
                 ((< 3 3) \"less\")
                 (else \"equal\"))"
        tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
        expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq('greater')
      end
    end

    context "when the second conditional is true" do
      it "returns the second expression" do
        string =
          "(cond ((< 3 1) \"greater\")
                 ((< 3 4) \"less\")
                 (else \"equal\"))"
        tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
        expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq('less')
      end
    end

    context "when neither conditional is true" do
      it "returns the else expression" do
        string =
          "(cond ((> 3 3) \"greater\")
                 ((< 3 3) \"less\")
                 (else \"equal\"))"
        tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
        expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq('equal')
      end
    end
  end

  context "and operation" do
    context "when the and is true" do
      it "returns true" do
        string = "(and (= 2 2) (> 2 1))"
        tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
        expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(true)
      end
    end

    context "when the and is false" do
      it "returns false" do
        string = "(and (< 3 2) (< 2 1))"
        tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
        expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(false)
      end
    end
  end

  it "can remove comments" do
    string = "(add 10 ; remove this\n3 ; and this\n)"
    tokenizer = Lisp::Tokenizer.new(StringIO.new(string))
    expect(evaluator.lisp_eval(parser.parse(tokenizer.read_s_expr))).to eq(13)
  end
end
