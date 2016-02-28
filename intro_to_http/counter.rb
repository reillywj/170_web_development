require 'socket'
require 'pry'
require_relative 'http_parser'
require_relative 'html_tags'

DOMAIN = 'localhost'
PORT = 3003
server = TCPServer.new(DOMAIN, PORT)

INCREMENT = 5

def add_to_number(client, number, increment)
  a_tag(client, "http://#{DOMAIN}:#{PORT}/?number=#{number.to_i + increment}") do
      "Add #{increment}"
    end
end

def return_body client, params
  wrap(client, "h1") {client.puts 'Counter'}
  number = params["number"] || 0
  wrap(client) {client.puts "The current number is #{number}"}

  wrap(client, 'p') do
    add_to_number client, number, INCREMENT
  end
  
  wrap(client, 'p') do
    add_to_number client, number, -INCREMENT
  end
end

def http_response(client, response)
  client.puts response
end

def http_headers(client, headers)
  headers.each do |header|
    client.puts "#{header[0]}: #{header[1]}"
  end
  client.puts
end

def http_body(client, http_method, path, params)
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
end

# Server processing
loop do
  client = server.accept

  request_line = client.gets
  puts request_line

  next unless request_line
  http_method, path, params = HTTPParser.parse(request_line)

  http_response client, 'HTTP/1.0 200 OK'
  http_headers client, [['ContentType', 'text/html']]
  http_body client, http_method, path, params

  client.close
end
