module Api
  module V1
    class TasksController < Api::V1::ApiController
      before_action :doorkeeper_authorize!

      def index
        app_monitor =
          current_account_user.app_monitors.find(params[:filter][:app_monitor_id])

        # TODO: add date param
        tasks = app_monitor.tasks
        render json: tasks
      end
    end
  end
end
