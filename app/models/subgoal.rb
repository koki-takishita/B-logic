class Subgoal < ApplicationRecord
  belongs_to :goal
  attr_accessor :selectbox_parameter
  attr_accessor :division_remainder

  validates :embodiment, presence: true, length: { maximum: 255 }
  validates :unit, presence: true, length: { maximum: 10 }
  validates :subgoal, presence: true, length: { maximum: 100 }
  validates :quantification, presence: true
  validates :deadline_on, presence: true

  def delivery_time_to_month(object)
    day = ApplicationController.helpers.days_left(object.deadline_on)
    if object.respond_to?(:goal)
      day= ApplicationController.helpers.days_left(object.goal.deadline_on)
      dec_day = ApplicationController.helpers.days_left(object.deadline_on)
      day = day.to_i - dec_day.to_i
    end
    month = if day.to_i >= (Date.today.next_month - Date.today).to_i
      one_month = (Date.today.next_month - Date.today).to_i
      month = day.to_i.divmod(one_month)
      # 余り格納 save時に使用する
      # hiddenfieldで保持
      self.division_remainder = month[1]
      month[0]
    else
      division_remainder = day
      '0'
    end
  end

  def remainder(remainder, goal)
    self.deadline_on = self.deadline_on + (remainder.to_i).day
    self.deadline_on = goal.deadline_on if self.deadline_on > goal.deadline_on
  end
end
