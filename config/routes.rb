Rails.application.routes.draw do
  root to: 'posts#new'
  get 'posts/confirm/:id', to: 'posts#confirm', as: 'confirm'
  get 'posts/download/:id', to: 'posts#download', as: 'download'
  resources :posts, only:[:new, :create]
end
