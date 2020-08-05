class UpdateEventsTable < ActiveRecord::Migration[6.0]
  def change
    rename_column :events, :user_id, :user_id
    add_column :events, :group_id, :integer
  end
end
