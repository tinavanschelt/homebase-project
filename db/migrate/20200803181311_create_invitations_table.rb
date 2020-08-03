class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.integer :group_id, null: false
      t.integer :user_id, null: false
      t.string :email, null: false
      t.boolean :accepted, default: false

      t.timestamps
    end
  end
end
