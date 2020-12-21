class CreateProdutos < ActiveRecord::Migration[6.0]
  def change
    create_table :produtos do |t|
      t.string :nome
      t.text :descricao
      t.integer :quantidade
      t.references :tipo_produto, null: false, foreign_key: true

      t.timestamps
    end
  end
end
