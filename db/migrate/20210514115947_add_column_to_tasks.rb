class AddColumnToTasks < ActiveRecord::Migration[5.2]
 def change
  add_column :tasks, :expired_at, :datetime, null: false
  add_reference :tasks, :status, null: false, foreign_key: true, default: 1

  # add_column :tasks, :expired_at, :datetime, default: -> { 'NOW()' }, null: false,
  end
end