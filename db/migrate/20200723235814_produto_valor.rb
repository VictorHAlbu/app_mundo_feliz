class ProdutoValor < ActiveRecord::Migration[6.0]
  def change
    add_column :produtos, :valor, :float
  end
end
