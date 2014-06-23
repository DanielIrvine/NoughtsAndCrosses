require 'game'

module NoughtsAndCrosses
  module Web
    class WebDisplay
    
      def call(env)
        
        page = ''
        game = Game.new(true, true, false)
        next_player = game.next_player
        game.board.available_spaces.each do |sq|
          game.set_next_human_move(sq)
          board = next_player.make_move(game.board)
          link = create_link(game, board_link(board))
          page += "<a href=\"#{link}\"/>\n"
        end
        ['200',
         {'Content-Type' => 'text/html'},
         page ]
      end
    
    
      def board_link(board)
        board_str = ''
        
        board.all_indexes.each do |sq|
          board_str += board.mark_at(sq)
        end
        board_str
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
