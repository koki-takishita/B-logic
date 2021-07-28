module TimeMethods
  def tense_of_the_time(time)
    case time
    when :now then
      time_local(now_year, now_month, now_day)
    when :past then
      time_local_past(now_year, now_month, now_day)
    when :feature then
      time_local_feature(now_year, now_month, now_day)
    end
  end

  private

    def time_local(year, month, day)
      Time.zone.local(year, month, day)
    end

    def time_local_past(year, month, day)
      Time.zone.local(year, month, day).yesterday
    end

    def time_local_feature(year, month, day)
      Time.zone.local(year, month, day).tomorrow
    end

    def now_year
      Time.zone.now.year
    end

    def now_month
      Time.zone.now.month
    end

    def now_day
      Time.zone.now.day
    end

end
