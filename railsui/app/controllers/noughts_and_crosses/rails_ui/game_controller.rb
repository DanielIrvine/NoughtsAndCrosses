require 'strings'
require 'game_strings'
require 'game_state'
require 'game'
require 'json_game'

module NoughtsAndCrosses
  module RailsUi

    class GameController < ApplicationController
      def index
      end

      def get_board
        game = Web::JsonGame.get_board(params)
        render :json => game.create_json 
        save_session(game.result)
      end

      def make_move
        game = Web::JsonGame.make_move_with_params(session, params[:sq])
        json = game.create_json
        save_session(game.result)
        render :json => json
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
