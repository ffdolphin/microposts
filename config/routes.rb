Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users, except: [:destroy]
  resources :users do
  	# memberの場合は必ずidが必要。collectionの場合はcreateやnewで使う。
  	member do
  		get 'followings'
      get 'followers'
  	end
  end

  resource :user do
    collection do
      get 'list'
    end
  end

  concern :paginatable do
    get '(page/:page)', :action => :index, :on => :collection, :as => ''
  end

  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts, :concerns => :paginatable
  resources :relationships, only: [:create, :destroy]
end