Rails.application.routes.draw do
  get 'reimbursement/update'
  get 'reimbursement/destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  put '/reimbursement/:id', to: 'reimbursement#update'
  delete '/reimbursement/:id', to: 'reimbursement#destroy'
end
