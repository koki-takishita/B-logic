class Issue < ApplicationRecord
  include Enum_status
  belongs_to :goal
  has_many :tasks, dependent: :destroy
end
