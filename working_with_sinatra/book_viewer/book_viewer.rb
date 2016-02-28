require "sinatra"
require "sinatra/reloader"
require 'tilt/erubis'

get "/" do
  # File.read "public/template.html"
  # erb :home
  @title = 'The Adventures of Sherlock Holmes'
  @author = 'Sir Arthur Doyle'
  @chapters = []
  File.open('./data/toc.txt').each do |line|
    @chapters << line.chomp
  end
  erb :home
end
