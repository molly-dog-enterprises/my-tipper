class CreateSents < ActiveRecord::Migration
  def change
    create_table :sents do |t|
      t.references :user, index: true, foreign_key: true
      t.references :fixture, index: true, foreign_key: true
      t.string :email_type
      t.timestamps null: false
    end
  end
end
