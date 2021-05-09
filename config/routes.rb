Rails.application.routes.draw do
  resources :administradors
  resources :pedidos do
    resources :pedido_produtos
  end
  root to:'home#index'
  resources :clientes
  resources :produtos
  resources :tipo_produtos
  
  get '/admin', to: 'admin#index'
  get '/login', to: 'login#index'
  post '/login/logar', to: 'login#logar'
  post '/login/sair', to: 'login#index'

  get '/produto/:produto_id', to: 'ecommerce#index'
  get '/produto/:produto_id/adicionar', to: 'ecommerce#adicionar'
  get '/produto/:produto_id/remover', to: 'ecommerce#remover'
  get '/carrinho', to: 'ecommerce#carrinho'
  get '/carrinho/fechar', to: 'ecommerce#fechar_carrinho'
  get '/cliente/logar', to: 'ecommerce#login'
  post '/cliente/login', to: 'ecommerce#fazer_login_cliente'
  get '/cliente/cadastrar', to: 'ecommerce#cadastrar'
  post '/cliente/criar', to: 'ecommerce#cadastrar_cliente'
  post '/cliente/sair', to: 'ecommerce#sair'
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
