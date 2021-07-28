class Task < ApplicationRecord
  include Enum_status
  enum task_type: { single_task: 0, routine_task: 1 }
  belongs_to :issue
  belongs_to :user
  validates :name, presence: true

  def task_type_check
    if routine_task?
      self.deadline_on = nil
      task_type
    else
      self.time_limit = nil
      task_type
    end
  end
end
