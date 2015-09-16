desc "This task is called by the Heroku scheduler add-on"
task :email_pending_games => :environment do

  ['2015', 'test'].each do |event|

    puts "Updating feed..."
    soon_users = User.includes(leagues: :fixtures).where(leagues: {name: event}, fixtures: {at: Time.now..6.hours.from_now}).select do |user|
      user.leagues[0].fixtures.any? do |fixture|
        !Pick.where(user_id: user.id, fixture_id: fixture.id).where.not(pick: nil).any?
      end
    end


    sent_users = []
    soon_users.each do |user|
      fixture = user.picks[0].fixture
      unless Sent.find_by(user: user, fixture: fixture, email_type: 'soon')
        sent_users << user
        PendingGame.soon(user.email, fixture).deliver_now
        Sent.create(user: user, fixture: fixture, email_type: 'soon')
      end
    end

    users = User.includes(leagues: :fixtures).where(leagues: {name: event}, fixtures: {at: 6.hours.from_now..1.day.from_now}).select do |user|
      user.leagues[0].fixtures.any? do |fixture|
        !Pick.where(user_id: user.id, fixture_id: fixture.id).where.not(pick: nil).any?
      end
    end

    (users - sent_users).each do |user|
      fixture = user.picks[0].fixture
      unless Sent.find_by(user: user, fixture: fixture, email_type: 'today')
        PendingGame.today(user.email, fixture).deliver_now
        Sent.create(user: user, fixture: fixture, email_type: 'today')
      end
    end
  end
end
