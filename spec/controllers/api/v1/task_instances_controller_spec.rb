require 'rails_helper'

RSpec.describe Api::V1::TaskInstancesController do
  describe "tracking" do
    let!(:application) { FactoryGirl.create :application } # OAuth application
    let!(:user_account_access) { FactoryGirl.create :user_account_access }
    let!(:user) { user_account_access.user }
    let!(:account) { user_account_access.account }
    let!(:access_token) { FactoryGirl.create :access_token, application: application, resource_owner_id: user.id }
    let!(:app_monitor) { FactoryGirl.create :app_monitor, account: account }

    it "tracks new task instance" do
      post :track, params: {
        access_token: access_token.token,
        task_name: "task 1",
        task_instance_uuid: SecureRandom.uuid,
        start_time: DateTime.current,
        monitor_id: app_monitor.id
      }
      binding.pry
      expect(response.status).to eq(201)
    end
  end
end
