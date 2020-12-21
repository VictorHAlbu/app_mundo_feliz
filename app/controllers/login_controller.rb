class LoginController < ApplicationController
    skip_before_action :verify_authenticity_token, :valida_logado_admin 
    
    layout "login"
    def index;end 

    def logar
        administradores = Administrador.where(email: params[:email], senha: params[:senha]) #busca no banco
        if administradores.count > 0 #se for mais que 0
            administrador = administradores.first #a variavel administrador vai receber o primeiro""first" que foi encontrado no banco[administrador,email - senha]
            time = params[:lembrar] == "1" ? 1.year.from_now : 30.minutes.from_now
            value ={
                id: administrador.id,
                nome: administrador.nome,
                email: administrador.email
            }
            cookies[:mundo_feliz_adm] = {value: value.to_json, expires: time, httponly: true}
            redirect_to "/admin"
        else
            flash[:error] = "Email ou senha inválidos"
            redirect_to "/login"
        end    
    end
    def sair
        cookies[:mundo_feliz_adm] = nil
        redirect_to "/login"
    end 
end
