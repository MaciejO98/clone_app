Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }
  get 'users/:id' => 'users#show'
  root 'pages#index'
  resources :posts
  put '/post/:id/like', to: 'posts#like', as: 'like'
end
