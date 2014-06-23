require 'game'
require 'board'
require 'strings'

module NoughtsAndCrosses
  module Web
    class WebDisplay
      
      include Strings

      OK = '200'
      ERROR = '400'
    
      def call(env)
        
        path = env['PATH_INFO'].split('/')
        return show('') if path.empty? 

        board_str = path.last
        
        return show('Invalid board', ERROR) if !Board.valid_board_str(board_str)

        game = Game.new(human?(path[0]),
                        human?(path[1]), 
                        board: board_str)
        
        page = ''
        if(!game.game_over? && game.next_player.kind_of?(ComputerPlayer))
          new_board = game.next_player.make_move(game.board)
          link = refresh_link(game, new_board.to_s)
        end
        page += add_header(game, link)
        game.board.all_indexes.each do |sq|
          page += "<p>#{process_square(sq, game)}</p>"
        end

        if game.game_over?
          page += "<p>#{add_result(game)}</p>"
        else
          page += "<p>#{add_play_turn(game)}</p>"
        end

        show(page)
      end
      
      def human?(name)
        name==player_type(HumanPlayer)
      end
    
      def process_square(sq, game)
        return game.board.mark_at(sq) if game.board.played?(sq)
        if(game.next_player.kind_of?(HumanPlayer))
          game.set_next_human_move(sq)
          board = game.next_player.make_move(game.board)
          link = create_link(game, board.to_s)
          "<a href=\"#{link}\">-</a>"
        else
          "-"
        end
      end

      def add_header(game, extra = nil)
       "<html><head><title>#{translate(:game_title)}</title>#{extra}</head>"
      end
      
      def refresh_link(game, board_str)
        link = create_link(game, board_str)
        "<meta http-equiv=\"refresh\" content=\"1; URL=#{link}\"/>"
      end

      def add_play_turn(game)
        if game.next_player.kind_of?(HumanPlayer)
          translate(:human_move, game.next_player.mark)
        else
          translate(:computer_move, game.next_player.mark)
        end
      end

      def add_result(game)
        if game.board.drawn?
          translate(:drawn)
        else
          translate(:winner, game.board.winner)
        end
      end

      def show(page, status = OK)
        ['200',
         {'Content-Type' => 'text/html'},
         page ]
      end

      def create_link(game, board_str)
        "/#{player_type(game.x.class)}/#{player_type(game.o.class)}/#{board_str}"
      end

      def player_type(player)
        player.name.split('::').last
      end
    end
  end

end
