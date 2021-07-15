class Subgoal < ApplicationRecord
  include Validators
  include Enum_status
  belongs_to :goal
  attr_accessor :division_remainder
  validates :subgoal, presence: true, length: { maximum: 100 }
end
