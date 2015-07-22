# You Only Write Once

A little programming language experiment exploring explicit control of variable scope.

## Hmm?

When you create a variable in YOWO, you choose its scope resolution rules by prepending it with a sigil:

* '_' or nothing: The variable is resolved lexically (The standard scoping rule in most languages)
* '$': The variable is resolved dynamically (ie, up the call stack)
* '#': The variable is resolved up the module hierarchy
* ':': The variable is resolved up the inheritance hierarchy

Also, variable scopes are first-class objects. Ie, you can access the current scope of each type directly (with the bare sigil) and manipulate it at will.

## Why?

Not sure yet. Seems like it might produce some cool things.

## What's with the name?

YOWO's *probably* gonna end up a write once, read never kind of language.

## Are you *seriously* writing an interpreter in Ruby?

For the performance!
