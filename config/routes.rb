Rails.application.routes.draw do

  # Routes for Google authentication
  # /auth/google_oauth2
  get 'auth/:provider/callback', to: 'sessions#google_login'
  get 'auth/failure', to: redirect('/')

  get 'logout', to: 'sessions#logout'

  # Events page
  get 'events/index'

  # root
  root 'home#index'
end
