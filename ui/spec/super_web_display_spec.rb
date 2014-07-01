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

      let(:server) { Capybara::Server.new(SuperWebDisplay.new).boot }
      let(:url) { "http://localhost:#{server.port}/" }

      include_context :rack 
      
      it 'shows the create game screen' do
        visit url
        expect(page).to have_content 'Board size is...'
      end


      it 'shows a blank board when game it submitted' do
        
      end
    end
  end
end
