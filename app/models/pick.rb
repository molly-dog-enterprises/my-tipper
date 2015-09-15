class Pick < ActiveRecord::Base
  belongs_to :user
  belongs_to :fixture

  attr_accessor :force_write

  validate :allowed_to_edit_pick_value?
  validates_uniqueness_of :user_id, scope: :fixture_id
  validates :pick, numericality: true

  def allowed_to_edit_pick_value?
    if !force_write && fixture.at <= Time.now.utc && changed.include?('pick')
      errors.add(:pick, 'can no longer be edited')
    end
  end
end
