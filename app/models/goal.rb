class Goal < ApplicationRecord
  # enum
  include Enum_status
  belongs_to :user
  has_many :issues, dependent: :destroy

  def expiration_date_cannot_be_in_the_past
    if expiration_date.present? && deadline < Date.today
      errors.add(:expiration_date, ": 過去の日付は使えません")
    end
  end 

end
