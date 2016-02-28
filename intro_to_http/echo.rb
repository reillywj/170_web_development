require 'socket'
require_relative 'http_parser'
require_relative 'html_tags'

server = TCPServer.new("localhost", 3003)

def print_rolls(client, rolls)
  rolls.each_with_index do |roll, index|
    wrap(client) {client.puts "Roll #{index + 1}: #{roll}"}
  end
end

def sum_rolls(rolls)
  sum = 0
  rolls.each do |roll|
    sum += roll
  end
  sum
end

def average_rolls(rolls)
  sum_rolls(rolls).to_f / rolls.size.to_f
end

def print_summary(client, rolls)
  wrap(client) {client.puts "Summation: #{sum_rolls rolls}"}
  wrap(client) {client.puts "Average: #{average_rolls rolls}"}
end

def summarize(client, rolls, params)
  number_of_rolls = params["rolls"] || "1"
  number_of_sides = params["sides"] || "6"

  number_of_sides = "1000" if number_of_sides.to_i > 1000

  wrap(client, 'h1') { client.puts "#{rolls.size} rolls of #{number_of_sides}-sided die" }
  wrap(client, 'strong') { client.puts "#{number_of_rolls} was too many. Reduced to #{rolls.size} rolls."} if number_of_rolls.to_i > 1000
  hr client


  if rolls.size > 1
    print_summary client, rolls
    hr client
  end

  print_rolls client, rolls
end

def roll_dice(params, client)
  number_of_rolls = params["rolls"] || "1"
  number_of_sides = params["sides"] || "6"
  sum = 0

  rolls = []

  number_of_rolls.to_i.times do |num|
    break if num + 1 > 1000
    rolls << rand(number_of_sides.to_i) + 1
  end

  rolls
end

def return_body(client, params)
  rolls = roll_dice params, client
  summarize client, rolls, params
end

loop do
  client = server.accept

  request_line = client.gets
  puts request_line

  next unless request_line

  # client.puts request_line
# GET /?rolls=2&sides=6 HTTP/1.1
  # http_method = HTTPParser.method(request_line)
  # path = HTTPParser.path(request_line)
  # params = HTTPParser.params(request_line)
  http_method, path, params = HTTPParser.parse(request_line)
  client.puts "HTTP/1.0 200 OK"
  client.puts "ContentType: text/html"
  client.puts
  wrap(client, 'html') do
    wrap(client, 'body') do
      wrap(client, 'pre') do
        client.puts "Method: #{http_method}"
        client.puts "Path: #{path}"
        client.puts "Params: #{params}"
      end

      return_body client, params
    end
  end

  client.close
end