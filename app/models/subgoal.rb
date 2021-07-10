class Subgoal < ApplicationRecord
  include Attr_accssor
  include Status
  include Validators
  include Enum_status
  belongs_to :goal
  attr_accessor :division_remainder
  validates :subgoal, presence: true, length: { maximum: 100 }

  def remainder(remainder, goal)
    self.deadline_on = self.deadline_on + (remainder.to_i).day
    self.deadline_on = goal.deadline_on if self.deadline_on > goal.deadline_on
  end
end
