class CreateUrl < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.belongs_to :users #establece una coneccion con la tabla de usuarios
      t.integer :user_id
      t.string :url_anterior
      t.string :url_nueva
      t.integer :click_count
      t.timestamp
    end
  end
end
