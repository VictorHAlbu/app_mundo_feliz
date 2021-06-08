class IuguCustommerId < ActiveRecord::Migration[6.0]
  def change
    add_column :clientes, :iugo_customer_id, :string
  end
end
