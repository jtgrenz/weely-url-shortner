Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root to: redirect('/url_maps/new')
  root 'url_maps#new'

  resources :url_maps, param: :token

  get '/:token', to: 'url_maps#short_url_redirect'
end
