class Subgoal < ApplicationRecord
  include Validators
  include Enum_status
  belongs_to :goal, dependent: :destroy
  has_many :tasks
  validates :subgoal, presence: true, length: { maximum: 100 }
end
