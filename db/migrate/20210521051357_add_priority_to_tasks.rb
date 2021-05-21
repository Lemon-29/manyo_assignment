class AddPriorityToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :column, :task
    add_column :tasks, :priority, :integer
  end
end
