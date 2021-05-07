module AdministradorsHelper
        def existe_carrinho?(id)#verifica se existe produto.id no carrinho
            return false if cookies[:carrinho].blank?#senão tiver produto return false
                produtos = JSON.parse(cookies[:carrinho]);#preenche o cookie e joga na variavel produtos
                produtos.include?(id.to_s)
    end              
end
