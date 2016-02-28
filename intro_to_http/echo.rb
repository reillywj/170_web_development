require 'socket'

server = TCPServer.new("localhost", 3003)

def parse_request(request)

end

loop do
  client = server.accept

  request_line = client.gets
  puts request_line

  client.puts request_line
# GET /?rolls=2&sides=6 HTTP/1.1
  # http_method == "GET"
  # path == '/'
  # params = {"rolls" => "2", "sides" => "6"}

  client.puts rand(6) + 1

  client.close
end