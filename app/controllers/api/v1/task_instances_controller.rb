module Api
  module V1
    class TaskInstancesController < Api::V1::ApiController
      before_action :check_monitor_api_key
      before_action :check_start_params, only: :start

      before_action :check_end_params, only: :end

      def start
        find_or_create_task

        @task_instance =
          @task.task_instances.create(uuid: params[:task_instance_uuid])

        @task_instance.update(start_time: params[:start_time])

        render_task_instance
      end

      def end
        @task_instance =
          current_account_user.task_instances.find_by_uuid!(params[:task_instance_uuid])
        @task_instance.update(end_time: params[:end_time])
        render_task_instance
      end

      private

      def render_task_instance
        if @task_instance.valid?
          render json: @task_instance, status: :ok
        else
          render json: @task_instance,
                 status: :unprocessable_entity,
                 serializer: ActiveModel::Serializer::ErrorSerializer
        end
      end

      def check_start_params
        if params[:start_time].blank?
          render json: { error: "Missing start_time param." }, status: 422
        end
      end

      def check_end_params
        if params[:end_time].blank?
          render json: { error: "Missing end_time param." }, status: 422
        end
      end

      def find_or_create_task
        task_name = params[:task_name]
        @task =
          @app_monitor.tasks.find_by_name(task_name) ||
            @app_monitor.tasks.create(name: task_name)
      end

      def check_monitor_api_key
        @app_monitor = AppMonitor.find_by_api_key(params[:monitor_api_key])

        if params[:monitor_api_key].blank?
          render json: { error: "Missing monitor_api_key param." }, status: 422
        elsif @app_monitor.blank?
          render json: { error: "Invalid monitor_api_key param." }, status: 422
        end
      end
    end
  end
end
