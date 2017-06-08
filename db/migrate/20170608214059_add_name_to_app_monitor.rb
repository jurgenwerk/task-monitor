class AddNameToAppMonitor < ActiveRecord::Migration[5.1]
  def change
    add_column :app_monitors, :name, :string, null: false, index: true
  end
end
