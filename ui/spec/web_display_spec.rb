require 'spec_helper'
require 'rack_helpers'
require 'web_display'

module NoughtsAndCrosses
  module Web
    describe WebDisplay do

      include_context :rack

      let(:display) { WebDisplay.new }

      it 'displays a web page' do
        result = display.call(get_request('')) 
        expect(result[0]).to eq '200'
        expect(result[1]['Content-Type']).to eq 'text/html'
      end

      it 'displays an empty board' do
        result = display.call(get_request('HumanPlayer/HumanPlayer/---------'))
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

      it 'displays a board after one move' do
        result = display.call(get_request('HumanPlayer/HumanPlayer/X--------'))

        expect(result).to have_link_to_path('HumanPlayer/HumanPlayer/XO-------')
        expect(result).to have_link_to_path('HumanPlayer/HumanPlayer/X-O------')
        expect(result).to have_link_to_path('HumanPlayer/HumanPlayer/X--O-----')
        expect(result).to have_link_to_path('HumanPlayer/HumanPlayer/X---O----')
        expect(result).to have_link_to_path('HumanPlayer/HumanPlayer/X----O---')
        expect(result).to have_link_to_path('HumanPlayer/HumanPlayer/X-----O--')
        expect(result).to have_link_to_path('HumanPlayer/HumanPlayer/X------O-')
        expect(result).to have_link_to_path('HumanPlayer/HumanPlayer/X-------O')
      end

      it 'displays error with invalid board size' do
        response = display.call(get_request('H/H/X--'))
        expect(response).to include('Invalid board')
      end

      it 'displays error with invalid board content' do
        response = display.call(get_request('H/H/ABCDEFGHI'))
        expect(response).to include('Invalid board')
      end
    end
  end
end
