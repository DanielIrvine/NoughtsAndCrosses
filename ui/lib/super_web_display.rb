require 'web_display'
require 'strings'
require 'json'

module NoughtsAndCrosses
  module SuperWeb
    class SuperWebDisplay < Web::WebDisplay

      def initialize
        @template_dir = File.dirname(__FILE__) + '/../templates/super/'

        @routes = { 
                    'game'  => -> (request) { start_game(request) },
                    'make_move' => -> (request) { make_move(request) },
                    'get_board' => -> (request) { initial_board(request) },
        }
      end

      def call(env)
        request = Rack::Request.new(env)

        route = request.path.sub('/','')
        if(@routes.has_key?(route))
          @routes[route].call(request)
        else
          show(START_TEMPLATE, binding)
        end
      end
      
      def start_game(request)
        board_size = request["size"].to_i
        show(GAME_TEMPLATE, binding)
      end

      def initial_board(request)
        result = Web::JsonGame.get_board(request.params)
        show_json(result)
      end

      def make_move(request)
        result = Web::JsonGame.make_move_with_params(request.params)
        show_json(result)
      end

      def show_json(json_game)
        [ OK,
          {'Content-Type' => 'application/json'},
          [json_game] ]
      end

    end
  end
end
