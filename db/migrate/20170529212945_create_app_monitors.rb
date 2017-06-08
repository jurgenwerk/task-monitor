class CreateAppMonitors < ActiveRecord::Migration[5.1]
  def change
    create_table :app_monitors do |t|
      t.references :account, index: true, foreign_key: true
      t.timestamps
    end
  end
end
