class TeamWrappersController < ApplicationController
  before_action :authenticate_admin!

  def index
    wrappers = TeamWrapper.where.not(name: nil)
    wrappers = wrappers.includes(:fixtures).where(fixtures: {event: event})
    @wrappers_by_round = wrappers.group_by {|w| w.fixture.round }
  end

  def create
    params[:wrappers].each do |wrapper, value|
      next if value.blank?

      wrapper_id = wrapper.split('_').last.to_i

      TeamWrapper.find(wrapper_id).update_attributes(team_id: value)
    end
    redirect_to team_wrappers_path(event: params[:event])
  end
end
