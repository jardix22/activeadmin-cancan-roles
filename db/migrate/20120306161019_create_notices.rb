class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.string :title
      t.text :description
      t.references :admin_user

      t.timestamps
    end
    add_index :notices, :admin_user_id
  end
end
