class Goal < ApplicationRecord
  # enum
  include Enum_status
  belongs_to :user
  has_many :issues, dependent: :destroy
  validates :name, :deadline, presence: true
  validate :deadline_cannot_be_in_the_past 

  def deadline_cannot_be_in_the_past
    if deadline.present? && deadline <= Date.today
      errors.add(:expiration_date, ": 明日以降の日付を選択してください")
    end
  end 

end
