class PicksController < ApplicationController
  before_action :authenticate_user!, except: :current_admin
  skip_before_action :authenticate_user!, if: :current_admin

  def index
    fixtures = Fixture.includes({home: :team}, {away: :team}).order(:at)
    fixtures = fixtures.where(event: event)
    fixtures = fixtures.where(['at > ?', Time.now.utc]) unless params[:display] == 'all'

    @fixtures_by_round = fixtures.all.group_by(&:round)
    @pick = Pick.where(user_id: current_user.id).group(:fixture_id).maximum(:pick) # returns hash of {fixture_id => pick_value}
  end

  def create
    params[:picks].each do |fixture, value|
      next if value.blank?

      fixture_id = fixture.split('_').last.to_i
      pick = Pick.find_or_initialize_by(fixture_id: fixture_id, user_id: current_user.id)
      pick.update_attributes(pick: value.to_i)
    end
    redirect_to picks_path(event: params[:event])
  end
end
