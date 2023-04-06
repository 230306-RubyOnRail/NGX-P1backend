Rails.application.routes.draw do
  get 'user/create'
  get 'reimbursement/update'
  get 'reimbursement/destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/user/new', to: 'user#create'
  post '/login', to: 'sessions#create'


  put '/reimbursement/:id', to: 'reimbursement#update'
  delete '/reimbursement/:id', to: 'reimbursement#destroy'
end
