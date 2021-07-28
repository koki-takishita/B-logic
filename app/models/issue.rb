class Issue < ApplicationRecord
  include Enum_status
  belongs_to :goal
  belongs_to :user
  has_many :tasks, dependent: :destroy
  validates :name, :solution, presence: true
end
