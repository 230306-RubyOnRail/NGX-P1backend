Rails.application.routes.draw do
  get 'user/create'
  # get 'reimbursement/update'
  # get 'reimbursement/destroy'
  get 'reimbursement/:id', to: 'reimbursement#show'
  get 'reimbursement/', to:'reimbursement#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/user/new', to: 'user#create'

  # post '/login', to: 'sessions#create'
  post '/reimbursement/:id', to: 'reimbursement#create'
  post '/auth/login', to: 'sessions#create'
  get '/users', to: 'user#index'



  put '/reimbursement/:id', to: 'reimbursement#update'
  delete '/reimbursement/:id', to: 'reimbursement#destroy'
end
