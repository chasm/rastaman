Rastaman::Application.routes.draw do
  root 'site#index'

  get     'login'  => 'session#new'
  post    'login'  => 'session#create'
  delete  'logout' => 'session#destroy'
  get     'logout' => 'session#destroy' # TEMPORARY

  get  'register/:sign_up_code' => 'registration#new', as: :registration_form
  post 'register/:sign_up_code' => 'registration#create'

  get   'reset/:password_reset_code' => 'password#edit', as: :password_reset_form
  patch 'reset/:password_reset_code' => 'password#update'

  get 'privacy-policy' => 'site#privacy'
  get 'terms-of-use' => 'site#terms'
end
