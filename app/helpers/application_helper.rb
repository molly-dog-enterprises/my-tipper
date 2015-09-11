module ApplicationHelper
  def current_selection(fixture, pick_value)
    if pick_value.blank? or pick_value == 0
      ''
    elsif pick_value < 0
      "#{fixture.home.name} by #{pick_value.to_i.abs}"
    else
      "#{fixture.away.name} by #{pick_value.to_i.abs}"
    end
  end
end
