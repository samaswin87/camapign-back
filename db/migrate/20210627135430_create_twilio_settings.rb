class CreateTwilioSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :twilio_settings do |t|
      t.string :sid
      t.string :token
      t.integer :company_id
      t.integer :status, default: 0

      t.timestamps
    end

    add_index :twilio_settings, :company_id

    add_foreign_key :twilio_settings, :companies, column: :company_id
  end
end
