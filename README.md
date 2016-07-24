# Lisp

> A Simple Lisp Interpreter

A simple list interpreter based on the python interpreter
implemented here http://norvig.com/lispy.html

## Installation
    git clone https://github.com/slabounty/lisp

## Running 
    # pry
    [1] pry(main)> require_relative 'lisp'
    [2] pry(main)> repl
    > (define l (list a b c))
    (a b c)
    > (car l)
    a
    > (cdr l)
    (b c)
    >

## TODO
### Complete numerous functions
#### Add
#### Subtract
#### Multiply
#### Divide
#### Apply (map?)
#### Etc (see list in standard_env from the link
### Add Tests
### Easier to run repl (should be able to do it from command line)
### Way to exit repl (exit?)
### Make more "ruby" like (class maybe :) )
