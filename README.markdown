DataMapper Async
=========

An optionally-asynchronous special case for Ruby on Rails models, backed by DataMapper.

Usage
-----

To use **dm-async** in one of your resource, simply `include` `DataMapper::Asynchronous::Resource` instead of `DataMapper::Resource`:

     class MyModel
       include DataMapper::Asynchronous::Resource
     
       # ... your model here

     end


Adding callbacks
----------------

`dm-async` is simple:

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

Include a module in your code that defines the methods outlined in `DataMapper::Asynchronous::RemoteHandlers`.

    # Handler
    module MyHandler
      def remote_after_save
        ...
      end
    end
    
    # Model
    class Model
      include DataMapper::Asynchronous::Resource
      ...
      include MyHandler      
      ...
    end
    
## Special note on server configuration

The server will pass along all ordering information from Datamapper.  You should expect a params-array of `order_by[]` values:

    ...?order_by[]=name%3Adesc&order_by[]=id%3Aasc
