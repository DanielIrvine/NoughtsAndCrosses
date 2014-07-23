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
          get 'get_board', x: 'HumanPlayer', o: 'HumanPlayer', size: 3
          expect(response).to be_success
        end
      end

      describe "GET 'make_move'" do
        it "returns http success" do
          get 'get_board', x: 'HumanPlayer', o: 'HumanPlayer', size: 3
          get 'make_move', sq: 1
          expect(response).to be_success
        end
      end

    end
  end
end
