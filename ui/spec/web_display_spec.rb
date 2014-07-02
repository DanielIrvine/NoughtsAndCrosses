require 'spec_helper'
require 'rack_helpers'
require 'web_display'
require 'strings'

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
        response = display.call(get_request('game/HumanPlayer/HumanPlayer/---------'))
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
        response = display.call(get_request('game/HumanPlayer/HumanPlayer/X--------'))

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
        response = display.call(get_request('game/HumanPlayer/HumanPlayer/X--'))
        expect(response[2].first).to include(Strings.translate(:invalid_board))
      end

      it 'displays error with invalid board content' do
        response = display.call(get_request('game/HumanPlayer/HumanPlayer/ABCDEFGHI'))
        expect(response[2].first).to include(Strings.translate(:invalid_board))
      end

      it 'displays board state text in correct order' do
        response = display.call(get_request('game/HumanPlayer/HumanPlayer/XOX---OXO'))
        expect(response[2]).to have_ordered_strings(%w{X O X O X O})
      end

      it 'prompts user to make a move' do
        response = display.call(get_request('game/HumanPlayer/HumanPlayer/XOX---OXO'))
        expect(response[2].first).to include(Strings.translate(:human_move, 'X'))
      end

      it 'prompts when computer is making a move' do
        response = display.call(get_request('game/ComputerPlayer/HumanPlayer/XOX---OXO'))
        expect(response[2].first).to include(Strings.translate(:computer_move, 'X'))
      end

      it 'displays no links when computer is making a move' do
        response = display.call(get_request('game/ComputerPlayer/HumanPlayer/XOX---OXO'))
        expect(response).to_not have_link_to_path('/XOXX--OXO')
      end

      it 'contains a redirect when computer move is playing' do
        response = display.call(get_request('game/ComputerPlayer/HumanPlayer/XX-OO----'))
        expect(response[2]).to have_refresh_link('/XXXOO----')
      end

      it 'displays board result when game is over' do
        response = display.call(get_request('game/ComputerPlayer/HumanPlayer/XXXOO----'))
        expect(response[2].first).to include(Strings.translate(:winner, 'X'))
      end

      it 'displays board result when game is drawn' do
        response = display.call(get_request('game/ComputerPlayer/HumanPlayer/XOXOXOOXO'))
        expect(response[2].first).to include(Strings.translate(:draw))
      end

      it 'does not display any links when the board is complete' do
        response = display.call(get_request('game/HumanPlayer/HumanPlayer/XXXOO----'))
        expect(response).to_not have_link_to_path('HumanPlayer/HumanPlayer/XXXOOO---')
      end

    end
  end
end
