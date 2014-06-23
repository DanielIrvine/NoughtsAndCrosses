require 'spec_helper'
require 'rack_helpers'
require 'web_display'
require 'strings'

module NoughtsAndCrosses
  module Web
    describe WebDisplay do

      
      include Strings
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
        response = display.call(get_request('HumanPlayer/HumanPlayer/X--'))
        expect(response).to include('Invalid board')
      end

      it 'displays error with invalid board content' do
        response = display.call(get_request('HumanPlayer/HumanPlayer/ABCDEFGHI'))
        expect(response).to include('Invalid board')
      end

      it 'displays board state text in correct order' do
        response = display.call(get_request('HumanPlayer/HumanPlayer/XOX---OXO'))
        expect(response).to have_ordered_strings(%w{X O X - - - O X O})
      end

      it 'prompts user to make a move' do
        response = display.call(get_request('HumanPlayer/HumanPlayer/XOX---OXO'))
        expect(response[2]).to include(translate(:human_move, 'X'))
      end

      it 'prompts when computer is making a move' do
        response = display.call(get_request('ComputerPlayer/HumanPlayer/XOX---OXO'))
        expect(response[2]).to include(translate(:computer_move, 'X'))
      end

      it 'displays no links when computer is making a move' do
        response = display.call(get_request('ComputerPlayer/HumanPlayer/XOX---OXO'))
        expect(response).to_not have_link_to_path('/XOXX--OXO')
      end

      it 'contains a redirect when computer move is playing' do
        response = display.call(get_request('ComputerPlayer/HumanPlayer/XX-OO----'))
        expect(response).to have_refresh_link('/XXXOO----')
      end

      it 'displays board result when game is over' do
        response = display.call(get_request('ComputerPlayer/HumanPlayer/XXXOO----'))
        expect(response[2]).to include('X wins!')
      end
    end
  end
end
