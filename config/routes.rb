Rails.application.routes.draw do
  root to: 'posts#new'
  get 'posts/confirm/:id', to: 'posts#confirm', as: 'confirm'
  get 'posts/download/:id', to: 'posts#download', as: 'download'
  resources :posts, only:[:new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
