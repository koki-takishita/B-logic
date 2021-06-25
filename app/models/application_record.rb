class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def when_deadline(month)
    if self.persisted?
      # 現在の締切日から❍ヶ月後
      self.deadline_on = self.deadline_on.since(month.month)
      # ここに余りがあれば足す処理追加
      if self.respond_to?(:division_remainder)
        self.deadline_on = self.deadline_on.since((self.division_remainder.to_i).days)
      end
      self.deadline_on
    else
      # 締切を今日の日付 + ❍ヶ月後に設定
      deadline = Date.today >> month
      self.deadline_on = deadline.end_of_day
     end
  end

end
