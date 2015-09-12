class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.references :league, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
