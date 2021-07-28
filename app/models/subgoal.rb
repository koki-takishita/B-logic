class Subgoal < ApplicationRecord
  include Validators
  include Enum_status
  belongs_to :goal
  has_many :tasks, dependent: :destroy
  validates :subgoal, presence: true, length: { maximum: 100 }
end
