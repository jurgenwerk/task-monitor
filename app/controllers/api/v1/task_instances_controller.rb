module Api
  module V1
    class TaskInstancesController < Api::V1::ApiController
      before_action :check_params

      def track
        app_monitor = current_account.app_monitors.find(params[:monitor_id])
        task = find_or_create_task(app_monitor)
        task_instance = find_or_create_task_instance(task)
        task_instance.update(
          start_time: params[:start_time],
          end_time: params[:end_time])

        if task_instance.valid?
          render json: task_instance, status: :ok
        else
          render json: task_instance,
                 status: :unprocessable_entity,
                 serializer: ActiveModel::Serializer::ErrorSerializer
        end
      end

      private

      def check_params
        if params[:task_name].blank?
          render json: { error: "Missing name param." }, status: 422
        elsif params[:task_instance_uuid].blank?
          render json: { error: "Missing task_instance_uuid param." }, status: 422
        elsif params[:monitor_id].blank?
          render json: { error: "Missing monitor_id param." }, status: 422
        elsif params[:start_time].blank? && params[:end_time].blank?
          render json: { error: "Missing start_time or end_time param." }, status: 422
        end
      end

      def find_or_create_task_instance(task)
        task_instance_uuid = params[:task_instance_uuid]
        task.task_instances.find_by_uuid(task_instance_uuid) ||
          task.task_instances.create(uuid: task_instance_uuid)
      end

      def find_or_create_task(app_monitor)
        task_name = params[:task_name]
        app_monitor.tasks.find_by_name(task_name) ||
          app_monitor.tasks.create(name: task_name)
      end
    end
  end
end
