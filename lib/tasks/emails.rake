desc "This task is called by the Heroku scheduler add-on"
task :email_pending_games => :environment do

  ['2015', 'test'].each do |event|

    sent_users = []
    Fixture.where(at: Time.now..6.hours.from_now).order('at DESC').each do |fixture|
      users = User.all - fixture.picks.map(&:user)
      (users - sent_users).each do |user|
        next if Sent.find_by(user: user, fixture: fixture, email_type: 'soon')
        sent_users << user
        PendingGame.soon(user.email, fixture).deliver_now
        Sent.create(user: user, fixture: fixture, email_type: 'soon')
      end
    end

    Fixture.where(at: 6.hours.from_now..1.day.from_now).order('at DESC').each do |fixture|
      users = User.all - fixture.picks.map(&:user)
      (users - sent_users).each do |user|
        next if Sent.find_by(user: user, fixture: fixture, email_type: 'today')
        sent_users << user
        PendingGame.today(user.email, fixture).deliver_now
        Sent.create(user: user, fixture: fixture, email_type: 'today')
      end
    end
  end
end


# users = User.includes(leagues: :fixtures).where(leagues: {name: event}, fixtures: {at: 6.hours.from_now..1.day.from_now}).select { |user| user.leagues[0].fixtures.any? { |fixture| !Pick.where(user_id: user.id, fixture_id: fixture.id).where.not(pick: nil).any?}}
