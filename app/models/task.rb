class Task < ApplicationRecord
  include Enum_status
  enum task_type: { single_task: 0, continuation_task: 1 }
  belongs_to :subgoal, dependent: :destroy
end
