class PendingGame < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.pending_game.today.subject
  #
  def today(to, fixture)
    mail to: to,
      from: 'my-tipper@decoybecoy.com',
      subject: "Who do you think will win? #{fixture.home.name} v #{fixture.away.name}"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.pending_game.soon.subject
  #
  def soon(to, fixture)
    mail to: to,
      from: 'my-tipper@decoybecoy.com',
      subject: "Who do you think will win? #{fixture.home.name} v #{fixture.away.name}"
  end
end
