class HTTPParser

  def self.method(request)
    request.split(' ').first
  end

  def self.path(request)
    path_and_params(request).first
  end

  def self.params(request)
    raw_params = path_and_params(request)[1]
    return_hash = {}

    raw_params.split('&').each do |pair|
      split_pair = pair.split('=')
      return_hash[split_pair.first] = split_pair[1]
    end if raw_params

    return_hash
  end

  def self.path_and_params(request)
    request.split(' ')[1].split('?')
  end
end
