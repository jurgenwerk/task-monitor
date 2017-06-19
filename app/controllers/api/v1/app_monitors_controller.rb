module Api
  module V1
    class AppMonitorsController < Api::V1::ApiController
      before_action :doorkeeper_authorize!

      def index
        render json: current_account_user.app_monitors
      end

      def show
        render json: current_account_user.app_monitors.find(params[:id])
      end

      def create
        app_monitor =
          current_account.app_monitors.build(app_monitor_params)

        if app_monitor.save
          render json: app_monitor
        else
          render json: app_monitor,
                 status: :unprocessable_entity,
                 serializer: ActiveModel::Serializer::ErrorSerializer
        end
      end

      private

      def app_monitor_params
        params.require(:data).require(:attributes).permit(:name)
      end
    end
  end
end
