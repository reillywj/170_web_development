require "sinatra"
require "sinatra/reloader"
require 'tilt/erubis'

before do
  @book_title = 'The Adventures of Sherlock Holmes'
  @author = 'Sir Arthur Doyle'
  @chapters = File.readlines('data/toc.txt')
end

get '/' do
  
  erb :index
end

get "/" do
  @title = @book_title
  erb :home
end

get '/chapter/:number' do
  @chapter_number = params['number']
  @title = "#{@chapter_number}: #{@chapters[@chapter_number.to_i - 1]}"
  @text = File.read("data/chp#{@chapter_number}.txt")

  erb :chapter
end