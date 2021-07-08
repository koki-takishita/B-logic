module Enum_status
  extend ActiveSupport::Concern

  included do
    enum status: { run: 0, done: 1, expired: 2 }
  end
end
