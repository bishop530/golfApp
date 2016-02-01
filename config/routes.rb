Rails.application.routes.draw do

  get 'scores/index'

  get 'scores/new'

  get 'scores_controller/index'

  get 'scores_controller/new'

  get 'password_resets/new'

  get 'password_resets/edit'

  get    'login'  =>  'sessions#new'
  post   'login'  =>  'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :courses
  #resources :rounds

  ######################################################################
  # Score is defined as a nested resource because a score is always
  # associated with a particular game and would not exist alone. The
  # actions for the ScoresController will always be passed a game_id
  # that identifies the game the score is associated with.
  ######################################################################
  resources :rounds do
    resources :scores
  end

  resources :golfers

  resources :account_activations, only: [:edit]

  resources :password_resets,     only: [:new, :create, :edit, :update]

  root 'home#home'
end
