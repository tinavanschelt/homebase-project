class AddFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null: false
    add_column :users, :dob, :datetime, null: true
    add_column :users, :role, :integer, null: true
  end
end
