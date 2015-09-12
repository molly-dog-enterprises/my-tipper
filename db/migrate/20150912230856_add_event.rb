class AddEvent < ActiveRecord::Migration
  def change
    add_column :fixtures, :event, :string
    Fixture.update_all(event: '2015')

    build_round(1, File.read(Rails.root.join('db/migrate/data/round-1')))

  end

  def build_round(round, data)
    data.split("\n").in_groups_of(4) do |match, time, loc, _|
      _, _, teams = match.split(/\s+/, 3)
      h, a = teams.split(/\s+v\s+/)
      home = Team.find_or_create_by(name: h)
      away = Team.find_or_create_by(name: a)
      Fixture.find_or_create_by(event: 'test', home_id: home.id, away_id: away.id, venue: loc, at: Time.parse(time).utc - 4.days, round: round)
    end
  end
end
