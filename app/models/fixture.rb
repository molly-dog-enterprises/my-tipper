class Fixture < ActiveRecord::Base
  belongs_to :home, class_name: 'Team'
  belongs_to :away, class_name: 'Team'
  has_many :picks

  def pick(user)
    picks.detect{ |p| p.user_id = user.id } || Pick.new

  end
end
