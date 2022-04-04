require 'active_record'

def connect_db!
  ActiveRecord::Base.establish_connection(
    host: 'localhost', 
    adapter: 'postgresql',
    database: 'wd_201_todos', 
    user: 'postgres', 
    password: 'postgres'
  )
end