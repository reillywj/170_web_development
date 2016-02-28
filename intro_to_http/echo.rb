require 'socket'
require_relative 'http_parser'

server = TCPServer.new("localhost", 3003)

def roll_dice(params, client)
  rolls = params["rolls"] || "1"
  sides = params["sides"] || "6"
  sum = 0

  client.puts "#{rolls} rolls of #{sides}-sided dice"
  rolls.to_i.times do |num|
    roll = rand(sides.to_i) + 1
    client.puts "Roll #{num + 1}: #{roll}" if rolls.to_i > 1
    client.puts "Roll: #{roll}" if rolls.to_i == 1
    sum += roll
  end

  if rolls.to_i > 1
    client.puts "Sum of Roll: #{sum}"
    client.puts "Average: #{sum.to_f / rolls.to_f}"
  end
end

loop do
  client = server.accept

  request_line = client.gets
  puts request_line

  client.puts request_line
# GET /?rolls=2&sides=6 HTTP/1.1
  http_method = HTTPParser.method(request_line)
  path = HTTPParser.path(request_line)
  params = HTTPParser.params(request_line)

  client.puts "Method: #{http_method}"
  client.puts "Path: #{path}"
  client.puts "Params: #{params}"

  roll_dice params, client

  client.close
end