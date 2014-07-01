require 'capybara'
require 'capybara/poltergeist'
require 'spec_helper'
require 'super_web_display'
require 'rack_helpers'

Capybara.javascript_driver = :poltergeist

module NoughtsAndCrosses
  module SuperWeb
    describe SuperWebDisplay do

      include_context :rack 
      
      let(:display) { SuperWebDisplay.new }

      it 'shows a blank board' do
        call = get_request("/game", 'POST', { size: 3,
                                              x: 'human',
                                              o: 'computer' })


        game = expect(display.call(call))
      end
    end
  end
end
