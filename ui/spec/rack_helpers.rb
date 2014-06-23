RSpec.shared_context :rack do


  RSpec::Matchers.define :have_link_to_path do |expected|
    match do |actual|
      /href="(.)*#{expected}"/.match(actual[2])
    end
  end

  def get_request(path)
    {'PATH_INFO' => path,
     'QUERY_STRING' => '',
     'REQUEST_METHOD' => 'GET' }
  end
end
