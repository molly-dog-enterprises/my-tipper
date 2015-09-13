module ApplicationHelper
  def current_selection(fixture, pick_value, force: false)
    if pick_value.blank? or pick_value == 0
      force ? 'Draw' : ''
    elsif pick_value < 0
      "#{fixture.home.real_name} by #{pick_value.to_i.abs}"
    else
      "#{fixture.away.real_name} by #{pick_value.to_i.abs}"
    end
  end
end
