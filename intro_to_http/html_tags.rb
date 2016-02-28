def wrap(client, tag_char = 'p')
  client.puts "<#{tag_char}>"
  yield if block_given?
  client.puts "</#{tag_char}>"
end

def hr(client)
  client.puts "<hr>"
end

def a_tag(client, link)
  client.puts "<a href='#{link}'>"
  client.puts yield if block_given?
  client.puts link unless block_given?
  client.puts "</a>"
end

def p_tag(client)
  wrap(client, 'p') do
    client.puts yield if block_given?
  end
end