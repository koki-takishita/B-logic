module Validators
  extend ActiveSupport::Concern

  included do
    validates :embodiment, presence: true
    validates :deadline_on, presence: true
    validates :unit, presence: true
    validates :quantification, presence: true
  end
end
