class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def when_deadline(month)
    byebug
    if self.persisted?
      # 締切日から❍ヶ月後
      self.deadline_on = months_later(month: month, time: deadline_on)
      # ここに余りがあれば足す処理追加
      if self.respond_to?(:division_remainder)
        #self.deadline_on = self.deadline_on.since((self.division_remainder.to_i).days)
        self.deadline_on = days_later(day: division_remainder, time: deadline_on)
      end
      deadline_on
    else
      # 締切を今日の日付 + ❍ヶ月後に設定
      self.deadline_on = months_later(month: month)
     end
  end

  def months_later(month: 0, time: current_time)
    time.advance(months: month.to_i)
  end

  def days_later(day: 0, time: current_time)
    time.advance(days: day.to_i)
  end

  def current_time
    Time.zone.now
  end

end
