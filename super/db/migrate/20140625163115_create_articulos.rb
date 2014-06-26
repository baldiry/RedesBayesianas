class CreateArticulos < ActiveRecord::Migration
  def change
    create_table :articulos do |t|
      t.string :descripcion
      t.decimal :precio
      t.string :tags

      t.timestamps
    end
  end
end
