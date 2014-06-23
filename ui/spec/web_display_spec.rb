require 'spec_helper'
require 'web_display'

RSpec::Matchers.define :have_link_to_path do |expected|
  match do |actual|
    /href="(.)*#{expected}"/.match(actual[2])
  end
end

module NoughtsAndCrosses
  module Web
    describe WebDisplay do

      let(:display) { WebDisplay.new }

      it 'displays a web page' do
        result = display.call( { 'PATH_INFO' => '',
                                 'QUERY_STRING' => '',
                         'REQUEST_METHOD' => 'GET' })

        expect(result[0]).to eq '200'
        expect(result[1]['Content-Type']).to eq 'text/html'
      end

      it 'displays an empty board' do

        result = display.call( { 'PATH_INFO' => 'H/H/---------',
                                 'QUERY_STRING' => '',
                                 'REQUEST_METHOD' => 'GET' })

        expect(result).to have_link_to_path('HumanPlayer/HumanPlayer/X--------')
        expect(result).to have_link_to_path('HumanPlayer/HumanPlayer/-X-------')
        expect(result).to have_link_to_path('HumanPlayer/HumanPlayer/--X------')
        expect(result).to have_link_to_path('HumanPlayer/HumanPlayer/---X-----')
        expect(result).to have_link_to_path('HumanPlayer/HumanPlayer/----X----')
        expect(result).to have_link_to_path('HumanPlayer/HumanPlayer/-----X---')
        expect(result).to have_link_to_path('HumanPlayer/HumanPlayer/------X--')
        expect(result).to have_link_to_path('HumanPlayer/HumanPlayer/-------X-')
        expect(result).to have_link_to_path('HumanPlayer/HumanPlayer/--------X')
      end

    end
  end
end
