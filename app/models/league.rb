require 'securerandom'

class League < ActiveRecord::Base
  has_many :players

  validates_uniqueness_of :name

  def create(current_user)
    League.transaction do
      self.code = SecureRandom.hex
      save || raise(ActiveRecord::Rollback)
      players.create(user_id: current_user.id) || raise(ActiveRecord::Rollback)
      return true
    end
    return false
  end
end
