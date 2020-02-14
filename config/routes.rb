Rails.application.routes.draw do

  resources :countries, only: [:index, :show]

  post '/result' => 'countries#result', :as => 'countries_result'

  root 'countries#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
