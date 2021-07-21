class Issue < ApplicationRecord
  belongs_to :goal
  has_many :tasks, dependent: :destroy
end
