require 'game_strings'
require 'spec_helper'
require 'super_web_display'
require 'rack_helpers'
require 'rack'

module NoughtsAndCrosses
  module SuperWeb
    describe SuperWebDisplay do

      let(:display) { SuperWebDisplay.new }
      let(:url) { "http://localhost:#{server.port}/" }

      include_context :rack 
      
      it 'makes the next move' do
        result = display.call(get_request('/make_move?sq=1&board=---------&x=HumanPlayer&o=HumanPlayer'))
        expect(json_from(result)['board']).to eq ('-X-------')
      end

      it 'plays a computer move' do
        result = display.call(get_request('/make_move?sq=&board=XX-OO----&x=ComputerPlayer&o=HumanPlayer'))
        expect(json_from(result)['board']).to eq('XXXOO----')
      end

      it 'notes when the computer is playing next' do
        result = display.call(get_request('/make_move?sq=0&board=---------&x=HumanPlayer&o=ComputerPlayer'))
        expect(json_from(result)['next_move']).to eq('computer')
      end

      it 'shows status text' do
        result = display.call(get_request('/make_move?sq=1&board=---------&x=HumanPlayer&o=ComputerPlayer'))
        game = Game.new(true, false, board:'X--------')
        expect(json_from(result)['status_text']).to eq(GameStrings.play_turn_text(game))
      end
      def json_from(result)
        JSON.parse(result[2][0])
      end

      it 'adds player info' do
        result = display.call(get_request('/make_move?sq=1&board=---------&x=HumanPlayer&o=ComputerPlayer'))
        expect(json_from(result)['x']).to eq('HumanPlayer')
        expect(json_from(result)['o']).to eq('ComputerPlayer')

      end
    end
  end
end
