class AddEventIndexToFixture < ActiveRecord::Migration
  def change
    add_index :fixtures, :event

    fixtures = build_rounds(File.read(Rails.root.join('db/migrate/data/previous')))
    build_picks(File.read(Rails.root.join('db/migrate/data/prev_picks')))
    fixtures.each {|f| f.update_result(f.result)}
  end

  def build_rounds(data)
    round = nil
    fixtures = []
    data.split("\n").in_groups_of(4) do |result, match, time, loc|
      result, r = result.split(' ')
      round = r if r
      h, a = match.split(/\s+v\s+/)
      home = get_wrap(h)
      away = get_wrap(a)
      fixtures << Fixture.find_or_create_by(event: '2011', home_id: home.id, away_id: away.id, venue: loc, at: Time.parse(time).utc, round: round, result: result)
    end
    fixtures
  end

  def build_picks(data)
    matches = Fixture.where(event: '2011').includes({home: :team}, {away: :team}).each_with_object({}) {|f, h| h["#{f.home.name} v #{f.away.name}"] = f.id }
    data.split("\n").each do |row|
      match, email, name, pick = row.split(/\s+\|\s+/)
      u = User.find_by(email: email, name: name) ||
        User.create!(email: email, name: name, password: 'please-change-me', password_confirmation: 'please-change-me')
      binding.pry if name == "David" and match == "Australia v Italy"
      f_id = matches[match]
      p = Pick.find_or_initialize_by(
        user_id: u.id,
        fixture_id: f_id,
        pick: pick.to_i * -1,
      )
      p.save(validate: false)
    end
  end

  def get_wrap(name)
    if name =~ /^(W |RU )/
      TeamWrapper.find_or_create_by(name: name)
    else
      home = Team.find_or_create_by(name: name)
      TeamWrapper.find_or_create_by(team_id: home.id, name: nil)
    end
  end
end
