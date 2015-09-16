class AddEventFlagToLeague < ActiveRecord::Migration
  def change
    add_column :leagues, :event, :boolean, default: false

    League.reset_column_information


    ['2015', '2011', 'test'].each do |event|
      l = League.create!(name: event, event: true).id
      users = Fixture.where(event: event).joins(:picks).where.not(picks: {pick: 0}).select('DISTINCT picks.user_id').map(&:user_id)
      users.each {|u| Player.create!(league_id: l, user_id: u)}
    end
  end
end
