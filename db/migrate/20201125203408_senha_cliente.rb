class SenhaCliente < ActiveRecord::Migration[6.0]
  def change
    add_column :clientes, :senha, :string
  end
end
