require 'rails_helper'

module NoughtsAndCrosses
  module RailsUi

    RSpec.describe GameController, :type => :controller do

      describe "GET 'index'" do
        it "returns http success" do
          get 'index'
          expect(response).to be_success
        end
      end

      describe "GET 'get_board'" do
        it "returns http success" do
          get 'get_board'
          expect(response).to be_success
        end
      end

      describe "GET 'make_move'" do
        it "returns http success" do
          get 'make_move'
          expect(response).to be_success
        end
      end

    end
  end
end
