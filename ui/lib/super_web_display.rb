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
        @path = env['PATH_INFO'].split('/').reject(&:empty?)

        case @path[0]
        when 'state' then 
          state = build_state(game_state_url_segment)
          show_json(state) 
        when 'game' then
          show(GAME_TEMPLATE, binding)
        else
          show(START_TEMPLATE, binding)
        end
      end

      def game_state_url_segment
        @path.drop(1)
      end

      def show_json(obj)
        [ OK,
          {'Content-Type' => 'application/json'},
          [JSON.generate(obj)] ]
      end
    end
  end
end
