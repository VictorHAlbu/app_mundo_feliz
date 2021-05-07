module ApplicationHelper
    def existe_carrinho?(id)
        return false if cookies[:carrinho].blank?
            produtos = JSON.parse(cookies[:carrinho]);
            produtos.include?(id.to_s)
    end              

    def quantidade_carrinho
        return 0 if cookies[:carrinho].blank?#retorna 0 se a quantidade de carrinho for 0
        return JSON.parse(cookies[:carrinho]).length #retorna a quantidade de quantos produtos existe no cariinho
    end              

end
