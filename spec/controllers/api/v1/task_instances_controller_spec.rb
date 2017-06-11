require 'rails_helper'

RSpec.describe Api::V1::TaskInstancesController do
  describe "tracking" do
    let!(:application) { FactoryGirl.create :application } # OAuth application
    let!(:user_account_access) { FactoryGirl.create :user_account_access }
    let!(:user) { user_account_access.user }
    let!(:account) { user_account_access.account }
    let!(:access_token) { FactoryGirl.create :access_token, application: application, resource_owner_id: user.id }
    let!(:app_monitor) { FactoryGirl.create :app_monitor, account: account }

    describe "start task instance" do
      context "with existing task" do
        let!(:task) { FactoryGirl.create :task, app_monitor: app_monitor,
          name: "send notifications" }

        it "saves new task instance with start time" do
          post :start, params: {
            access_token: access_token.token,
            task_name: task.name,
            task_instance_uuid: SecureRandom.uuid,
            start_time: 10.minutes.ago,
            monitor_id: app_monitor.id
          }

          task_instance_attrs = JSON.parse(response.body)
          task_instance = TaskInstance.find(task_instance_attrs["id"])
          expect(task_instance.task).to eq(task)
        end
      end
      context "with new task" do
        it "saves new task instance with start time" do
          start_time = DateTime.current.utc

          post :start, params: {
            access_token: access_token.token,
            task_name: "task 1",
            task_instance_uuid: SecureRandom.uuid,
            start_time: start_time,
            monitor_id: app_monitor.id
          }

          task_instance_attrs = JSON.parse(response.body)
          task_instance = TaskInstance.find(task_instance_attrs["id"])
          expect(task_instance.start_time.utc.to_s).to eq(start_time.to_s)
          expect(task_instance.end_time).to be_blank
          expect(response.status).to eq(200)
        end
      end
    end

    describe "end task instance" do
      let!(:task) { FactoryGirl.create :task, app_monitor: app_monitor }
      let!(:task_instance) {
        FactoryGirl.create :task_instance,
        task: task,
        start_time: 10.minutes.ago, uuid: SecureRandom.uuid }

      it "saves the end time" do
        end_time = DateTime.current.utc
        post :end, params: {
          access_token: access_token.token,
          task_instance_uuid: task_instance.uuid,
          end_time: end_time
        }

        expect(task_instance.start_time).to be_present
        expect(task_instance.reload.end_time.to_s).to eq(end_time.to_s)
        expect(response.status).to eq(200)
      end
    end
  end
end
