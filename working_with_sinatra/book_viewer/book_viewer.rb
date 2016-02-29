require "sinatra"
require "sinatra/reloader"
require 'tilt/erubis'

helpers do
  def in_paragraphs(text)
    return_text = ''
    text.split("\n\n").each_with_index do |line, index|
      return_text += "<p id='paragraph-#{index}'>#{line}</p>"
    end
    return_text
  end

  def highlight_phrase(paragraph, phrase)
    paragraph.gsub(phrase, "<strong>#{phrase}</strong>")
  end
end

before do
  @book_title = 'The Adventures of Sherlock Holmes'
  @author = 'Sir Arthur Doyle'
  @contents = File.readlines('data/toc.txt')
end

get "/" do
  @title = @book_title
  erb :home
end

get '/chapter/:number' do
  @chapter_number = params['number']
  @title = "#{@chapter_number}: #{@contents[@chapter_number.to_i - 1]}"
  @chapter = File.read("data/chp#{@chapter_number}.txt")

  erb :chapter
end

get '/search' do
  @title = 'Search'
  search_params = params['query']
  if search_params
    @possible_chapters = []
    @contents.each_with_index do |chapter_name, index|
      chapter = File.read("data/chp#{index+1}.txt").split("\n\n")
      chapter.each_with_index do |paragraph, paragraph_index|
        @possible_chapters << [index+1, chapter_name, paragraph, paragraph_index] if paragraph.index search_params
      end
    end
  end

  erb :search
end

not_found do
  redirect '/'
end