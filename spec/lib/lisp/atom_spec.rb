require 'spec_helper'

describe Lisp::Atom do
  describe ".build" do
    context "when the token is true" do
      it "returns the string" do
        expect(described_class.build("true")).to eq(true)
      end
    end

    context "when the token is false" do
      it "returns the string" do
        expect(described_class.build("false")).to eq(false)
      end
    end

    context "when the token is a quoted string" do
      it "returns the string" do
        expect(described_class.build('"hello"')).to eq("hello")
      end
    end

    context "when the token is a quoted string has spaces" do
      it "returns the string" do
        expect(described_class.build('"hello world"')).to eq("hello world")
      end
    end

    context "when the token is an integer" do
      it "returns the integer" do
        expect(described_class.build("-42")).to eq(-42)
      end
    end

    context "when the token is a float" do
      it "returns the float" do
        expect(described_class.build('42.0')).to eq(42.0)
      end
    end

    context "when the token is anything else" do
      it "returns the token as a symbol" do
        expect(described_class.build('hello')).to eq(:hello)
      end
    end
  end
end
