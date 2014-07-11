RSpec.shared_context :rack do

  RSpec::Matchers.define :have_link_to_path do |expected|
    match do |actual|
      /href="(.)*#{expected}"/.match(actual[2].flatten.first)
    end
  end

  RSpec::Matchers.define :have_ordered_strings do |expected|
    match do |actual|
      left_to_match = expected
      remaining = actual.flatten.first.gsub(/href="[^"]*"/, '')
      while !left_to_match.empty?
        return false if !remaining.include?(left_to_match.first)
        remaining = remaining.partition(left_to_match.first)[2]
        left_to_match.shift
      end
      true
    end
  end

  RSpec::Matchers.define :have_refresh_link do |expected|
    match do |actual|
      /<meta http-equiv="refresh" content="(.*)#{expected}"/.match(actual.flatten.first)
    end
  end

  def get_request(path, method = 'GET', content = nil)
    components = path.split('?')
    {'PATH_INFO' => components[0] || '',
     'QUERY_STRING' => components.length == 1 ? '' : components[1], 
     'REQUEST_METHOD' => method,
     'rack.input' => StringIO,
     'rack.request.query_hash' => content}
  end

  def body_of(result)
    result[2][0]
  end
end
