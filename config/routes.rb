Rails.application.routes.draw do
  root to: 'homes#top'
  get "/home/about" => "homes#about"
  devise_for :users
  get '/search', to: 'searchs#search'
  resources :users, only: [:show, :index, :edit, :update]  do
   resource :relationships, only: [:create, :destroy]
   get 'followings' => 'relationships#followings', as: 'followings'
   get 'followers' => 'relationships#followers', as: 'followers'
 end

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]
end
