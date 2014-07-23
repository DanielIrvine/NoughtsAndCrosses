Rails.application.routes.draw do

  scope module: 'noughts_and_crosses/rails_ui' do
   get 'game/index'
   get 'game/game'
   get 'game/get_board'
   get 'game/make_move'
   root 'game#index'
  end


end
