class CreatePlatformRecipients < ActiveRecord::Migration[6.1]
  def change
    create_table :platform_recipients do |t|
      t.integer :status, default: 0
      t.string :phone
      t.timestamp :archived_at
      t.integer :company_id
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :no_of_campaigns, default: 0
      t.string :keywords, array: true, default: []
      t.text :notes
      t.integer :gender, default: 1
      t.jsonb :custom_fields, default: {}
      t.string :tags, array: true, default: []

      t.integer :created_by_id
      t.integer :updated_by_id
      t.timestamps
    end

    add_index :platform_recipients, :company_id,           unique: true
    add_index :platform_recipients, :created_by_id,        unique: true
    add_index :platform_recipients, :updated_by_id,        unique: true
    add_index :platform_recipients, :first_name,           unique: true
    add_index :platform_recipients, :last_name,            unique: true
    add_index :platform_recipients, :phone,                unique: true
    add_index :platform_recipients, :status,               unique: true
    
    add_foreign_key :platform_recipients, :companies, column: :company_id
    add_foreign_key :platform_recipients, :users, column: :created_by_id
    add_foreign_key :platform_recipients, :users, column: :updated_by_id
  end
end
