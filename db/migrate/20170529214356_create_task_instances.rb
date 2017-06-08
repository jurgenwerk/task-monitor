class CreateTaskInstances < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'uuid-ossp'

    create_table :task_instances do |t|
      t.references :task, index: true, foreign_key: {on_delete: :cascade}
      t.datetime :start_time
      t.datetime :end_time
      t.uuid :uuid, default: 'uuid_generate_v4()'
      t.timestamps
    end
  end
end
