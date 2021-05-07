class EcommerceController < ApplicationController
    skip_before_action :valida_logado_admin 
    layout "site"

    def cadastrar
        @cliente = Cliente.new
    end
    
    def index
        @produto = Produto.find(params[:produto_id])
    end

    def adicionar
    if cookies[:carrinho].present?#verifica se carrinho ta presente
        produtos = JSON.parse(cookies[:carrinho]);#se tiver converte em json e joga no array de produtos
    else  
        produtos = [] #senão o array fica vazio
    end

    produtos << params[:produto_id]#passa as informações do produto adicionado para produtos
    produtos.uniq!#produto unico, ao add no carrinho, ele vai add uma vez sem repetir mesmo produto

    cookies[:carrinho] = {value: produtos.to_json, expires: 1.year.from_now, httponly: true}
    redirect_to "/"
   end 

   def remover
    if cookies[:carrinho].blank?
        redirect_to "/"
        return
    end
    produtos = JSON.parse(cookies[:carrinho]);
    produtos.delete(params[:produto_id])
    cookies[:carrinho] = {value: produtos.to_json, expires: 1.year.from_now, httponly: true}
    redirect_to "/carrinho"
  end

  def carrinho
    if cookies[:carrinho].blank?
        redirect_to "/"
        return 
  end
  
  produtos = JSON.parse(cookies[:carrinho]);#converte cookes em JSOn e joga em um array de cookies
  @produtos = Produto.where(id: produtos)#lista todos ids de produtos que estão adicionados no cookies de carrinho
  end

    def fechar_carrinho
        if cookies[:cliente_login].blank?
        redirect_to "/cliente/logar"
        return    
    end

    def login
        
    end


    def cadastrar_cliente
        @cliente = Cliente.new(cliente_params)
        if cliente.save
            redirect_to "/carrinho/fechar"
        else
            redirect_to "/cliente/cadastrar/cadastrar"
        end    
    end

      private
        def cliente_params
            params.require(:cliente).permit(:nome, :cpf, :telefone, :email, :endereco, :numero, :bairro, :cidade, :estado, :senha)
        end
        
  end 
end
