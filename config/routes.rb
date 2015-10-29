Rails.application.routes.draw do

  resources :items do
    post :update_row_order, on: :collection
  end
  
  devise_for :users

  root "items#index"
end
