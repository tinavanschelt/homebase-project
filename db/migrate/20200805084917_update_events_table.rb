class UpdateEventsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :group_id, :integer
  end
end
