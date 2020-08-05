class UpdateEventsTable < ActiveRecord::Migration[6.0]
  def change
    rename_column :events, :organiser_id, :user_id
    add_column :events, :group_id, :integer
  end
end
