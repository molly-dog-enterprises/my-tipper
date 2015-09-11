class Pick < ActiveRecord::Base
  belongs_to :user
  belongs_to :fixture

  validate :allowed_to_edit_pick_value?

  def allowed_to_edit_pick_value?
    if fixture.at >= Time.now.utc && changed.include?('pick')
      errors.add(:pick, 'can no longer be edited')
    end
  end
end
