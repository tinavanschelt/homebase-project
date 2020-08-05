class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.integer :organiser_id
      t.datetime :date
      t.string :title
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :all_day
      t.boolean :restricted

      t.timestamps
    end
  end
end
