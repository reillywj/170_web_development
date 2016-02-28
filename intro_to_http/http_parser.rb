class HTTPParser

  def self.method(request)
    request.split(' ').first
  end
end
