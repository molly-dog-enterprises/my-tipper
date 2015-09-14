module ApplicationHelper
  def current_selection(fixture, pick_value, force: false)
    if pick_value.blank? or pick_value == 0
      force ? 'Draw' : ''
    elsif pick_value < 0
      "#{fixture.home.short_name} by #{pick_value.to_i.abs}"
    else
      "#{fixture.away.short_name} by #{pick_value.to_i.abs}"
    end
  end

  def correct_team(fixture, pick)
    return '' unless fixture.result && pick
    return 'incorrect-pick' if fixture.result == 0 || pick == 0
    pick.to_f / fixture.result > 0 ? 'correct-pick' : 'incorrect-pick'
  end
end
