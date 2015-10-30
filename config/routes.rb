Rails.application.routes.draw do
  
  scope 'admin' do
    resources :users, except: [:new, :create] 
  end

  resources :items do
    post :update_row_order, on: :collection
  end
  
  devise_for :users

  root "items#index"
end
