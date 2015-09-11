class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :image

      t.timestamps null: false
    end

    # Add all the team data here.. maybe move this to a seed file later

  end
end
