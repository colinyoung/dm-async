OhmAsync
=========

An optionally-asynchronous special case for Ruby on Rails models, backed by Ohm, an ORM for Redis.

Usage
-----

To use *ohm_async**, simply subclass `Ohm::Asynchronous::Model` instead of `Ohm::Model`:

     class MyModel < Ohm::Asynchronous::Model

     end


Adding callbacks
----------------

`ohm_async` is simple:

      mine = MyModel.new
			mine.after {|params| 
				puts params.to_yaml
			}.save
			