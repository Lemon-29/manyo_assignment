class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table : statuses do |t|
      t.string :status_name
      t.string :title
      t.text :content
      t.integer :status

      t.timestamps
    end
  end
end
