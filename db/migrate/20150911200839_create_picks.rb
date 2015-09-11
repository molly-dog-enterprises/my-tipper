class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.references :user, index: true, foreign_key: true
      t.references :fixture, index: true, foreign_key: true
      t.integer :pick
      t.integer :score

      t.timestamps null: false
    end
  end
end
