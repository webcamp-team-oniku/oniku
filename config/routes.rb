Rails.application.routes.draw do

  root :to =>"public/homes#top"
  get '/about' =>"public/homes#about"
  resources :items, only: [:index,:show]


  scope module: :public do
    # 顧客側のマイページ,登録情報編集&更新
    get 'customers' => 'customers#show'
    get 'customers/edit' => 'customers#edit'
    patch 'customers' => 'customers#update'
    # 顧客側の退会確認画面,退会処理
    get '/customers/quit' => 'customers#quit'
    patch '/customers/out' => 'customers#out'
    # 顧客側のカート画面
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only: [:index, :update, :create, :destroy]


    post '/orders/confirm' => 'orders#confirm'
    get '/orders/thanks' => 'orders#thanks'

    resources :deliveries, only: [:index, :edit, :create, :update, :destroy]

    resources :orders, only: [:new, :create, :index, :show]

  end

  namespace :admin do
    root :to => "homes#top"
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :edit, :update, :show]
    resources :orders, only: [:show, :update]
    resources :order_items, only: [:update]
  end
  
   # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip:[:registrations, :passwords],controllers:{
    sessions: "admin/sessions"
  }

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

end
