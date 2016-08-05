# Lisp

> A Simple Lisp Interpreter

A simple list interpreter based on the python interpreter
implemented here http://norvig.com/lispy.html

This is much more "rubyized" with classes etc. Additionally,
although it's not standard scheme, having quoted strings in
lists is supported.

It's packaged as a gem, but not published yet.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lisp'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lisp


## Running 
    $ bin/repl
    > (define l (list "hello" "world" 3)
    > (car l)
      (hello)
    > (+ 3 4)
      7
    > (+ 3 (* 3 3))
      12
    > (exit)
    $

## TODO
* Complete numerous functions
    * Apply (map?)
    * Etc (see list in standard_env from the link

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/slabounty/lisp. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


