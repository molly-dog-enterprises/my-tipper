class FixturesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    fixtures = Fixture.includes(:home, :away)
    fixtures = fixtures.where(['at > ?', Time.now.utc]) if params[:display] == 'future'

    @fixtures_by_round = fixtures.all.group_by(&:round)
  end
end
