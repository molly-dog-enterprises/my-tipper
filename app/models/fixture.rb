class Fixture < ActiveRecord::Base
  belongs_to :home, class_name: 'TeamWrapper'
  belongs_to :away, class_name: 'TeamWrapper'
  has_many :picks

  validate :allowed_to_edit_result_value?

  def pick(user)
    picks.detect{ |p| p.user_id = user.id } || Pick.new
  end

  def update_score(result)
    Fixture.transaction do
      self.result = result
      self.save!

      picks.each do |pick|
        pick.score = score_for(pick.pick, result)
        pick.save!
      end
    end
  end

  private

  def allowed_to_edit_result_value?
    if at >= Time.now.utc && changed.include?('result')
      errors.add(:result, 'can not yet be edited')
    end
  end

  def score_for(pick, result)
    if pick == 0 # player must pick a score
      result + 20
    elsif pick == result
      return -10
    elsif (pick / pick.abs) == (result / result.abs)
      (pick - result).abs
    else
      pick.abs + result.abs + 5
    end
  end
end
