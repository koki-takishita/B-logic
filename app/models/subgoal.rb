class Subgoal < ApplicationRecord
  belongs_to :user
  belgs_to :goal

  validates :embodiment, presence: true, length: { maximum: 255 }
  validates :unit, presence: true, length: { maximum: 10 }
  validates :subgoal, presence: true, length: { maximum: 100 }
  validates :quantification, presence: true
  validates :deadline_on, presene: true
end
