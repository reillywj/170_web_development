require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'

def sort_order(params)

  @sort_order = if params['sort'] && params['sort'].downcase == 'asc'
                  -1
                else
                  1
                end
end

get '/' do
  @files = Dir.glob('./public/*').map {|file| File.basename(file)}
  sort_order params
  erb :index
end