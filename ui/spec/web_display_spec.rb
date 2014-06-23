require 'spec_helper'
require 'web_display'

module NoughtsAndCrosses
  module Web
    describe WebDisplay do

      it 'displays a web page' do
        w = WebDisplay.new

        result = w.call( { 'PATH_INFO' => '',
                         'REQUEST_METHOD' => 'GET' })

        expect(result[0]).to eq '200'
        expect(result[1]['Content-Type']).to eq 'text/html'
      end
    end
  end
end
