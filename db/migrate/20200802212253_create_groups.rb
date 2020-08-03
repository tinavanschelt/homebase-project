class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :title
      t.string :group_type

      t.timestamps
    end
  end
end
