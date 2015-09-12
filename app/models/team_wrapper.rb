class TeamWrapper < ActiveRecord::Base
  belongs_to :team

  def name
    names = [
      attributes["name"],
      team.try(:name)
    ].compact
    if names.length > 1
      %{
      <div style='display: inline-block'>
        #{names.join('<br>')}
      </div>
      }.html_safe
    else
      names.first
    end
  end

  def fixture
    Fixture.where(['home_id = ? or away_id = ?', id, id]).first
  end

  def image
    team.try(:image) || attributes["image"]
  end
end
