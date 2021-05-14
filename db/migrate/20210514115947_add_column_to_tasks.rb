class AddColumnToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :priority, :integer
    add_column :tasks, :date, :datetime
    add_column :tasks, :expired, :datetime
  end
end
