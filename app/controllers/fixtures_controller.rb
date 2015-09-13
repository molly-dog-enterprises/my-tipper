class FixturesController < ApplicationController
  before_action :authenticate_admin!, except: [:index]

  def index
    fixtures = Fixture.includes({home: :team}, {away: :team}).order(:at)
    fixtures = fixtures.where(event: event)
    fixtures = fixtures.where(['at > ?', Time.now.utc]) if params[:display] == 'future'

    @fixtures_by_round = fixtures.all.group_by(&:round)
  end

  def create
    params[:fixtures].each do |fixture, value|
      next if value.blank?

      fixture_id = fixture.split('_').last.to_i

      Fixture.find(fixture_id).update_result(value)
    end
    redirect_to fixtures_path(event: params[:event])
  end
end
