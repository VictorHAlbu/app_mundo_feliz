class ApplicationController < ActionController::Base
  before_action :valida_logado_admin

  def valida_logado_admin
    if cookies[:mundo_feliz_adm].present?
         hash_adm = JSON.parse(cookies[:mundo_feliz_adm])
        if hash_adm["id"].present?
          administradores = Administrador.where(id: hash_adm["id"])
         if administradores.count > 0
            @admiministrador = administradores.first
            return
           end
         end
      end
      redirect_to "/login"
   end
end
