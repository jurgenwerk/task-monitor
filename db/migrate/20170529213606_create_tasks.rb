class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.references :app_monitor, index: true, foreign_key: {on_delete: :cascade}
      t.string :name, null: false, index: true
      t.timestamps
    end
  end
end
