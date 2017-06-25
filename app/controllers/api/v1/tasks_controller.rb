module Api
  module V1
    class TasksController < Api::V1::ApiController
      before_action :doorkeeper_authorize!

      def index
        app_monitor =
          current_account_user.app_monitors.find(params[:filter][:app_monitor_id])

        # TODO: add date param
        date = Date.parse(params[:filter][:date])
        tasks =
          app_monitor
          .tasks
          .joins(:task_instances)
          .where("task_instances.created_at >= ?", date.beginning_of_day)
          .where("task_instances.created_at <= ?", date.end_of_day)

        render json: tasks
      end
    end
  end
end
