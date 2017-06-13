class AddMonitorKeyToAppMonitors < ActiveRecord::Migration[5.1]
  def change
    add_column :app_monitors, :api_key, :string, null: false, index: true
  end
end
