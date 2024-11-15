class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.integer :profile_id
      t.text :message
      t.string :notification_type
      t.string :delivery_method
      t.string :status
      t.timestamps
    end
  end
end
