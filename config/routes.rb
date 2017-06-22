Rails.application.routes.draw do

  namespace :managers do
	  get    "/login"   => "sessions#new"
	  post   "/login"   => "sessions#create"
	  delete "/logout"  => "sessions#destroy"
	end

  resources :tickets do
    resources :replies
  end

  root 'tickets#new'
end
