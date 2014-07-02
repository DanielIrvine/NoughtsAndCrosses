require 'game_state'
require 'web_display'
require 'strings'
require 'json'

module NoughtsAndCrosses
  module SuperWeb
    class SuperWebDisplay < Web::WebDisplay

      def initialize
        @template_dir = File.dirname(__FILE__) + '/../templates/super/'
      end

      def call(env)

        route, state = env['PATH_INFO'].split('/', 2).reject(&:empty?)
        case route 
        when 'state' then 
          game_state = Web::GameState.new(state)
          show_json(build_state(game_state.build))
        when 'game' then
          show(GAME_TEMPLATE, binding)
        else
          show(START_TEMPLATE, binding)
        end
      end

      def show_json(obj)
        [ OK,
          {'Content-Type' => 'application/json'},
          [JSON.generate(obj)] ]
      end
    end
  end
end
