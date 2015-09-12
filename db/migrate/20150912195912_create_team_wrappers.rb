class CreateTeamWrappers < ActiveRecord::Migration
  def change
    create_table :team_wrappers do |t|
      t.string :name
      t.string :image
      t.references :team, index: true, foreign_key: true

      t.timestamps null: false
    end



    Team.all.each do |team|
      tw = TeamWrapper.create(team_id: team.id)
      Fixture.where(home_id: team.id).update_all(home_id: tw.id)
      Fixture.where(away_id: team.id).update_all(away_id: tw.id)
    end

    build_round('Quarters', File.read(Rails.root.join('db/migrate/data/quarters')))
    build_round('Semi-finals', File.read(Rails.root.join('db/migrate/data/semi')))
    build_round('Finals', File.read(Rails.root.join('db/migrate/data/finals')))
  end

  def build_round(round, data)
    data.split("\n").in_groups_of(4) do |match, time, loc, _|
      _, _, teams = match.split(/\s+/, 3)
      h, a = teams.split(/\s+v\s+/)
      home = TeamWrapper.find_or_create_by(name: h)
      away = TeamWrapper.find_or_create_by(name: a)
      Fixture.find_or_create_by(home: home, away: away, venue: loc, at: Time.parse(time).utc, round: round)
    end
  end
end
