class Goal < ApplicationRecord
  # バリテーション
  include Validators
  # enum
  include Enum_status
  belongs_to :user
  has_many :subgoals, dependent: :destroy
  validates :what_to_do, presence: true

end
