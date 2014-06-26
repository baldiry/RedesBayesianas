class CreateCorreos < ActiveRecord::Migration
  def change
    create_table :correos do |t|
      t.string :remitente
      t.text :mensaje
      t.string :departamento

      t.timestamps
    end
  end
end
