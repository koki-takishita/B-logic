class Goal < ApplicationRecord
  belongs_to :user
  has_many :subgoals
  attr_accessor :selectbox_parameter

  enum status: { run: 0, done: 1, expired: 2 }
  validates :embodiment, presence: true
  validates :deadline_on, presence: true
  validates :unit, presence: true
  validates :what_to_do, presence: true
  validates :quantification, presence: true

  def done
    # 属性ではなく、ローカル変数になってしまう
    # status = :done
    self.status = :done
  end

  def expired
    self.status = :expired
  end

  def run
    self.status = :run
  end
end
