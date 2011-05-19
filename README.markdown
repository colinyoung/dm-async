OhmAsync
=========

An optionally-asynchronous special case for Ruby on Rails models, backed by Ohm, an ORM for Redis.

Usage
-----

To use **ohm_async** in one of your models, simply subclass `Ohm::Asynchronous::Model` instead of `Ohm::Model`:

     class MyModel < Ohm::Asynchronous::Model
     
       # ... your model here

     end


Adding callbacks
----------------

`ohm_async` is simple:

    mine = MyModel.new
    mine.after { |objects| 
      # `Objects` is an array of the asynchronously-loaded records.
    }.save
    
The `after` command adds a block of code that will be called after the data is loaded asynchronously.
    
Or, if you want to add it after a specific stage (`update`, `delete`, `validate`, etc):

    mine = MyModel.new
    mine.after_delete { |objects| 
      # `Objects` is an array of the asynchronously-loaded records.
    }
    mine.delete
    
    # after_delete's code will execute here.
    
Providing for callbacks params
------------------------------



