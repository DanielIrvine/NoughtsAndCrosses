require 'game_state'
require 'web_display'
require 'strings'
require 'json'

module NoughtsAndCrosses
  module SuperWeb
    class SuperWebDisplay < Web::WebDisplay

      def initialize
        @template_dir = File.dirname(__FILE__) + '/../templates/super/'

        @routes = { 'state' => -> (state) { provide_state(state) },
                    'game'  => -> (state) { start_game(state) } }
      end

      def provide_state(state)
        game_state = Web::GameState.new(state)
        show_json(build_state(game_state.build))
      end

      def start_game(_)
        show(GAME_TEMPLATE, binding)
      end

      def show_json(obj)
        [ OK,
          {'Content-Type' => 'application/json'},
          [JSON.generate(obj)] ]
      end
    end
  end
end
