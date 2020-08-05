class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.integer :creator_id
      t.integer :assigned_to
      t.string :title
      t.text :description
      t.datetime :due_at
      t.datetime :completed_at
      t.integer :completed_by
      t.boolean :restricted

      t.timestamps
    end
  end
end
