Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }
  get 'users/:id' => 'users#show'
  root 'pages#index'
end
