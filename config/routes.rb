Rails.application.routes.draw do
  resources :user_stocks, except: [:show, :edit, :update]
  devise_for :views
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get 'my_portfolio', to: 'users#my_portfolio'

  get 'stock_search', to: 'stocks#search'
end
