class ResultsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, if: :current_admin

  def index
    fixtures = Fixture.includes({home: :team}, {away: :team}, :picks).order(:at)
    fixtures = fixtures.where(event: event)
    # fixtures = fixtures.where(['at < ?', Time.now.utc])
    fixtures = fixtures.all

    @rounds = {}
    results = Hash.new(nil)
    fixtures.each_with_index do |fixture, i|
      if fixture.result
        keys = results.keys
        fixture.picks.each do |pick|
          results[pick.user_id] ||= i * 20 # make up for missed rounds
          results[pick.user_id] += pick.score
          keys.delete(pick.user_id)
        end
        keys.each { |k| results[k] += 20 } # make up for missed round
      end

      @rounds[fixture.id] = results.dup
    end

    @fixtures_by_round = fixtures.group_by(&:round)
  end
end
