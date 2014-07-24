require 'json_game'
require 'query_string_game'

module NoughtsAndCrosses
  module RailsUi

    class GameController < ApplicationController
      def index
      end

      def get_board
        game = Web::QueryStringGame.new_game(params[:x], params[:o], params[:size].to_i)
        save_and_render(game)
      end

      def make_move
        game = Web::QueryStringGame.next_move(session[:x],
                                              session[:o],
                                              session[:board],
                                              params[:sq])
        p game.board
        save_and_render(game)
      end

      def save_and_render(game)
        output = Web::JsonOutput.new(game)
        render :json => output.create_json
        save_session(output.result)
      end

      def game
        @board_size = params[:size].to_i
      end

      def save_session(game)
        session[:board] = game[:board]
        session[:x] = game[:x]
        session[:o] = game[:o]
      end
    end
  end
end
