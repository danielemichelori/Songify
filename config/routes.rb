Rails.application.routes.draw do
  get 'favorites/update'
  resources :music_events
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root             'static_pages#homepage'

  devise_for :users , controllers: {
    session: 'users/session',
    registration: 'users/registration',
    omniauth: 'users/omniauth',
    omniauth_callbacks: "users/omniauth_callbacks",
    confirmations: 'users/confirmations'}

  # rotte _header
  get 'homepage'       => 'static_pages#homepage'  #rotta homepage
  get 'concerts'       => 'static_pages#concerts'  #rotta concerti
  get 'artists'        => 'static_pages#artists'   #rotta artisti
  #get 'tweets'         => 'static_pages#tweets'    #rotta tweets
  get 'chatroom'       => 'static_pages#chatroom'  #rotta chatroom
  # rotte _footer
  get 'about'          => 'static_pages#about'     #rotta informazioni
  get 'contact'        => 'static_pages#contact'   #rotta contatti

  mount ActionCable.server => '/cable'

  resources :tweets
  resources :users, :only =>[:show, :index]
end
