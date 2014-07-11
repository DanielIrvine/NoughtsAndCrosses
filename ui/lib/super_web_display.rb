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
      
      def provide_request(request)
        game_request = Web::GameState.new(request)
        show_json(build_request(game_request.build))
      end

      def start_game(request)
        board_size = request.params["size"].to_i
        game = {}
        game[:board] = '-' * board_size * board_size
        game[:x] = request.params['x']
        game[:o] = request.params['o']
        game[:next_move] = "computer" if game[:x] == "ComputerPlayer"
        initial_json = JSON.generate(game)
        show(GAME_TEMPLATE, binding)
      end

      def make_move(request)
        game = Web::GameState.with_request(request).build
        sq = request.params["sq"]
        if !sq.empty?
          game.set_next_human_move(sq.to_i)
        end
        game.play_turn!

        show_json(create_json(game))
      end

      def create_json(game)

        result = { board: game.board, 
                   finished: game.game_over?,
                   x: player_name(game.x),
                   o: player_name(game.o)}

        if game.next_player.kind_of?(ComputerPlayer)
          result[:next_move] = 'computer'
        end

        if game.game_over?
          result[:status_text] = GameStrings.result_text(game.board)
        else
          result[:status_text] = GameStrings.play_turn_text(game)
        end

        result
      end

      def show_json(obj)
        [ OK,
          {'Content-Type' => 'application/json'},
          [JSON.generate(obj)] ]
      end

      def player_name(player)
        player.class.name.split('::').last
      end

    end
  end
end
