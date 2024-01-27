Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  post '/twitter/create_tweet', to: 'twitter#create_tweet'
end
