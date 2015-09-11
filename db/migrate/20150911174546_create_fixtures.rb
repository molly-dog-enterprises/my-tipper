class CreateFixtures < ActiveRecord::Migration
  def change
    create_table :fixtures do |t|
      t.string :round
      t.integer :home_id, index: true, foreign_key: true
      t.integer :away_id, index: true, foreign_key: true
      t.string :venue
      t.datetime :at
      t.integer :result

      t.timestamps null: false
    end

    build_round(1, File.read(Rails.root.join('db/migrate/data/round-1')))
    build_round(2, File.read(Rails.root.join('db/migrate/data/round-2')))
    build_round(3, File.read(Rails.root.join('db/migrate/data/round-3')))
    build_round(4, File.read(Rails.root.join('db/migrate/data/round-4')))
    build_round(5, File.read(Rails.root.join('db/migrate/data/round-5')))
    build_round(6, File.read(Rails.root.join('db/migrate/data/round-6')))
  end

  def build_round(round, data)
    data.split("\n").in_groups_of(4) do |match, time, loc, _|
      _, _, teams = match.split(/\s+/, 3)
      h, a = teams.split(/\s+v\s+/)
      home = Team.find_or_create_by(name: h)
      away = Team.find_or_create_by(name: a)
      Fixture.find_or_create_by(home: home, away: away, venue: loc, at: Time.parse(time).utc, round: round)
    end
  end
end
