require 'spec_helper'
require 'rack_helpers'
require 'web_display'

module NoughtsAndCrosses
  module Web
    describe WebDisplay do

      include_context :rack

      let(:display) { WebDisplay.new }

      it 'displays a web page' do
        response = display.call(get_request('')) 
        expect(response[0]).to eq '200'
        expect(response[1]['Content-Type']).to eq 'text/html'
      end

      it 'displays an empty board' do
        response = display.call(get_request('HumanPlayer/HumanPlayer/---------'))
        expect(response).to have_link_to_path('HumanPlayer/HumanPlayer/X--------')
        expect(response).to have_link_to_path('HumanPlayer/HumanPlayer/-X-------')
        expect(response).to have_link_to_path('HumanPlayer/HumanPlayer/--X------')
        expect(response).to have_link_to_path('HumanPlayer/HumanPlayer/---X-----')
        expect(response).to have_link_to_path('HumanPlayer/HumanPlayer/----X----')
        expect(response).to have_link_to_path('HumanPlayer/HumanPlayer/-----X---')
        expect(response).to have_link_to_path('HumanPlayer/HumanPlayer/------X--')
        expect(response).to have_link_to_path('HumanPlayer/HumanPlayer/-------X-')
        expect(response).to have_link_to_path('HumanPlayer/HumanPlayer/--------X')
      end

      it 'displays a board after one move' do
        response = display.call(get_request('HumanPlayer/HumanPlayer/X--------'))

        expect(response).to have_link_to_path('HumanPlayer/HumanPlayer/XO-------')
        expect(response).to have_link_to_path('HumanPlayer/HumanPlayer/X-O------')
        expect(response).to have_link_to_path('HumanPlayer/HumanPlayer/X--O-----')
        expect(response).to have_link_to_path('HumanPlayer/HumanPlayer/X---O----')
        expect(response).to have_link_to_path('HumanPlayer/HumanPlayer/X----O---')
        expect(response).to have_link_to_path('HumanPlayer/HumanPlayer/X-----O--')
        expect(response).to have_link_to_path('HumanPlayer/HumanPlayer/X------O-')
        expect(response).to have_link_to_path('HumanPlayer/HumanPlayer/X-------O')
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
