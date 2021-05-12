class Goal < ApplicationRecord
  belongs_to :user
  enum status: { inactive: 0, active: 1 }
  validates :embodiment, presence: true, if: :goal_active?
  validates :unit, presence: true, if: :goal_active?
  validates :do, presence: true, if: :goal_active?
  validates :quantification, presence: true, if: :goal_active?

  def goal_active?
    status == 'active'
  end
end
