class TaskInstanceSerializer < ActiveModel::Serializer
  attributes :id, :task_id, :start_time,
             :end_time, :uuid
end
