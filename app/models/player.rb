class Player < ActiveRecord::Base
  belongs_to :league
  belongs_to :user

  validates_uniqueness_of :user_id, scope: :league_id
end
