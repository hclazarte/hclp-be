class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :full_name
      t.string :email
      t.string :phone
      t.text :address
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :password_digest
      t.integer :user_role
      t.boolean :prefers_email
      t.boolean :prefers_sms
      t.boolean :prefers_in_app
      t.timestamps
    end
  end
end
