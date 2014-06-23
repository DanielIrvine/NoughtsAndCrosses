RSpec.shared_context :rack do


  RSpec::Matchers.define :have_link_to_path do |expected|
    match do |actual|
      /href="(.)*#{expected}"/.match(actual[2])
    end
  end

  RSpec::Matchers.define :have_ordered_strings do |expected|
    match do |actual|
      left_to_match = expected
      remaining = actual[2].gsub(/href="[^"]*"/, '')
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
      /<meta http-equiv="refresh" content="(.*)#{expected}"/.match(actual[2])
    end
  end

  def get_request(path)
    {'PATH_INFO' => path,
     'QUERY_STRING' => '',
     'REQUEST_METHOD' => 'GET' }
  end
end
