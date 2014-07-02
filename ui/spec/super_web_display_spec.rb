require 'capybara'
require 'capybara/poltergeist'
require 'capybara/rspec'
require 'spec_helper'
require 'super_web_display'
require 'rack_helpers'

Capybara.javascript_driver = :poltergeist

module NoughtsAndCrosses
  module SuperWeb
    describe SuperWebDisplay, :js => true, :type => :feature do

      let(:display) { SuperWebDisplay.new }
      let(:server) { Capybara::Server.new(display).boot }
      let(:url) { "http://localhost:#{server.port}/" }

      include_context :rack 
      
      it 'shows the create game screen' do
        visit url
        expect(page).to have_content 'Board size is...'
      end

      xit 'shows a blank board when game it submitted' do
        visit url
        click_button('Play')
        expect(page).to have_content "X's turn"

      end

      it 'provides json for an empty board' do
        result = display.call(get_request('state/HumanPlayer/HumanPlayer/---------'))

        expect(result[1]['Content-Type']).to eq 'application/json'
      end

      it 'provides links to next squares' do
        result = display.call(get_request('state/HumanPlayer/HumanPlayer/---------'))
        state = JSON.parse(body_of(result))
        expect(state['board'][0][0]).to eq({ 'link' => '/HumanPlayer/HumanPlayer/X--------' })
        expect(state['board'][2][2]).to eq({ 'link' => '/HumanPlayer/HumanPlayer/--------X' })
      end

      it 'provides next computer move' do
        result = display.call(get_request('state/HumanPlayer/ComputerPlayer/X--------'))
        state = JSON.parse(body_of(result))

        expect(state['next_move']).to eq '/HumanPlayer/ComputerPlayer/X---O----'
      end
    end
  end
end
