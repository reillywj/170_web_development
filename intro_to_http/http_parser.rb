class HTTPParser

  def self.method(request)
    initial_split(request).first
  end

  def self.path(request)
    path_and_params(request).first
  end

  def self.params(request)
    raw_params = path_and_params(request)[1]
    return_hash = {}

    raw_params.split('&').each do |pair|
      key, value = pair.split('=')
      return_hash[key] = value
    end if raw_params

    return_hash
  end

  def self.path_and_params(request)
    initial_split(request)[1].split('?')
  end

  def self.initial_split(request)
    request.split(' ')
  end
end
