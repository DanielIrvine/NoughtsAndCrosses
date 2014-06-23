require 'game'
require 'board'

module NoughtsAndCrosses
  module Web
    class WebDisplay
    
      def call(env)
        
        path = env['PATH_INFO']
        return show_start if path.empty? 

        board_str = env['PATH_INFO'].split('/').last
        
        return error('Invalid board') if !Board.valid_board_str(board_str)

        page = ''
        game = Game.new(true, true, board: board_str)
        next_player = game.next_player
        game.board.available_spaces.each do |sq|
          game.set_next_human_move(sq)
          board = next_player.make_move(game.board)
          link = create_link(game, board.to_s)
          page += "<a href=\"#{link}\"/>\n"
        end
        ['200',
         {'Content-Type' => 'text/html'},
         page ]
      end
    
      def show_start
        ['200',
         {'Content-Type' => 'text/html'},
         '' ]
      end

      def error(str)
        ['400',
         {'Content-Type' => 'text/html'},
         str ]
      end
    
      def create_link(game, board_str)
        "/#{player_type(game.x)}/#{player_type(game.o)}/#{board_str}"
      end

      def player_type(player)
        return player.class.name.split('::').last
      end
    end
  end

end
