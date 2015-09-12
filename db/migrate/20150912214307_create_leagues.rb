class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :name
      t.string :password
      t.string :code
      t.boolean :public

      t.timestamps null: false
    end
  end
end
