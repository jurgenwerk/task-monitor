class Task < ApplicationRecord
  belongs_to :app_monitor
  has_many :task_instances
end
