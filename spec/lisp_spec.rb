require 'spec_helper'

describe Lisp do
  it 'has a version number' do
    expect(Lisp::VERSION).not_to be nil
  end
end
