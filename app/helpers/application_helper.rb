module ApplicationHelper

  def parse_date(date)
    return date if date.is_a?(Date)
    begin
      Date.parse(date)
    rescue
      Date.today
    end
  end
end
