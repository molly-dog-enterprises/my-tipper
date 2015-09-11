class PicksController < ApplicationController
  before_action :authenticate_user!

  def index
    fixtures = Fixture.includes(:home, :away, :picks)
    fixtures = fixtures.where(['at > ?', Time.now.utc]) unless params[:display] == 'all'

    @fixtures_by_round = fixtures.all.group_by(&:round)
  end

  def create
    params[:picks].each do |fixture, value|
      next if value.blank?

      fixture_id = fixture.split('_').last.to_i
      pick = Pick.find_or_initialize_by(fixture_id: fixture_id, user_id: current_user.id)
      pick.update_attributes(pick: value.to_i)
    end
    redirect_to picks_path
  end
end
