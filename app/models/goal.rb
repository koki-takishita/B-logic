class Goal < ApplicationRecord
  # enum
  include Enum_status
  belongs_to :user
  has_many :issues, dependent: :destroy

end
