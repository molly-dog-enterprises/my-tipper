class HomeController < ApplicationController
  # before_action :authenticate_user!

  def index
    if event == '2015' && current_user
      # ensure the user is in the current event as soon as they log in (hack)
      Player.find_or_create_by(user: current_user, league_id: League.find_by(name: '2015').id)
    end
  end
end
