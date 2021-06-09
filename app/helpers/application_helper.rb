module ApplicationHelper
  def order_join(*names)
    object = names.map{|name| name.to_s}
    return object.join
  end

  def days_left(day)
    today = Date.today
    sa = day.to_date - today
    int = sa.to_i
    return int.to_s + '日'
  end
end
