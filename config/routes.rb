Rails.application.routes.draw do
  root to: 'posts#new'
  get 'posts/confirm/:id', to: 'posts#confirm', as: 'confirm'
  resources :posts, only:[:new, :create, :update, :edit, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
