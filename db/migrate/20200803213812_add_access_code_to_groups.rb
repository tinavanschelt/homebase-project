class AddAccessCodeToGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :access_code, :string
  end
end
