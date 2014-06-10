Rastaman::Application.routes.draw do
  root 'site#index'

  get     'login'  => 'session#new'
  post    'login'  => 'session#create'
  delete  'logout' => 'session#destroy'
  get     'logout' => 'session#destroy' # TEMPORARY

  get  'register/:sign_up_code' => 'registration#new', as: :register
  post 'register/:sign_up_code' => 'registration#create'

  get 'privacy-policy' => 'site#privacy'
  get 'terms-of-use' => 'site#terms'
end
