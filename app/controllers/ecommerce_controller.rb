class EcommerceController < ApplicationController
    skip_before_action :valida_logado_admin
    skip_before_action :verify_authenticity_token 
    layout "site"

    def cadastrar
        @cliente = Cliente.new
    end

    def cadastrar_cliente
        @cliente = Cliente.new(cliente_params)
        if @cliente.save
            cookies[:cliente_login] = { #depois que cadastrar guarda o cookie do cliente
                value: {#informaões guardadas no cookie de cliente
                    id: @cliente.id,
                    nome: @cliente.nome,
                    email: @cliente.email
                }.to_json, 
                expires: 1.year.from_now, httponly: true
                }
            redirect_to "/carrinho/fechar"
        else
            render :cadastrar
        end    
    end

    def sair
        cookies[:cliente_login] = nil
        redirect_to "/"
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
        if cookies[:cliente_login].blank?#se cokies de cliente não tiver preechido logue-se
        redirect_to "/cliente/logar"
        return    
        end
        #veririfa se carrinho ta em branco, senão tiver preeche o cookies[:carrinho]
        #E vai retornar no fechar_carrinhos todos produtos que estão no carrinho
        if cookies[:carrinho].blank?
            redirect_to "/"
            return 
        end
    
        produtos = JSON.parse(cookies[:carrinho]);#converte cookes em JSOn e joga em um array de cookies
        @produtos = Produto.where(id: produtos)#lista todos ids de produtos que estão adicionados no cookies de carrinho
    end

    def login
    end

    def fazer_login_cliente
        clientes = Cliente.where(email: params[:email], senha: params[:senha]) #busca no banco
        if clientes.count > 0 #se for mais que 0
            cliente = clientes.first #a variavel Cliente vai receber o primeiro""first" que foi encontrado no banco[Cliente,email - senha]
            time = params[:lembrar] == "1" ? 1.year.from_now : 30.minutes.from_now
            value ={
                id: cliente.id,
                nome: cliente.nome,
                email: cliente.email
            }
            cookies[:cliente_login] = {value: value.to_json, expires: time, httponly: true}
            redirect_to "/carrinho/fechar"
        else
            flash[:error] = "Email ou senha inválidos"
            redirect_to "/cliente/logar"
        end        
    end

    private
    def cliente_params
      params.require(:cliente).permit(:nome, :cpf, :telefone, :email, :cep, :endereco, :numero, :bairro, :cidade, :estado, :senha)
    end
end
