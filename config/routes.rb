Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]

  resources :users, only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  resources :judges, only: %i[index new]

  constraints Clearance::Constraints::SignedIn.new {|user| user.admin? } do
    root "judges#index", as: 'admin_root'
  end

  root 'home#index'
end
