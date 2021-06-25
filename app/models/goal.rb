class Goal < ApplicationRecord
  belongs_to :user
  has_many :subgoals
  attr_accessor :selectbox_parameter

  enum status: { inactive: 0, active: 1 }
  validates :embodiment, presence: true
  validates :deadline_on, presence: true
  validates :unit, presence: true
  validates :what_to_do, presence: true
  validates :quantification, presence: true

  def current_status
    self.status = deadline_on ? :active : :inactive
  end

end
