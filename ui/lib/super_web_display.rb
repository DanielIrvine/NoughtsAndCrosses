require 'web_display'
require 'query_string_game'
require 'json_output'

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
        select_route(route, request)
      end
      
      def start_game(request)
        board_size = request["size"].to_i
        show(GAME_TEMPLATE, binding)
      end

      def initial_board(request)
        game = Web::QueryStringGame.new_game(request.params["x"],
                                             request.params["o"],
                                             request.params["size"])
        show_json(game)
      end

      def make_move(request)
        game = Web::QueryStringGame.next_move(request.params["x"],
                                              request.params["o"],
                                              request.params["board"],
                                              request.params["sq"])
        show_json(game)
      end

      def show_json(game)
        json = Web::JsonOutput.new(game).create_json
        [ OK,
          {'Content-Type' => 'application/json'},
          [json] ]
      end

    end
  end
end
