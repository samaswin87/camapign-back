class CreatePlatformOperators < ActiveRecord::Migration[6.1]
  def change
    create_table :platform_operators do |t|
      t.integer :status, default: 0
      t.string :phone
      t.timestamp :archived_at
      t.integer :company_id
      t.string :name
      t.boolean :short_code, default: false

      t.integer :created_by_id
      t.integer :updated_by_id
      t.timestamps
    end

    add_index :platform_operators, :company_id,           unique: true
    add_index :platform_operators, :created_by_id,        unique: true
    add_index :platform_operators, :updated_by_id,        unique: true
    add_index :platform_operators, :name,                 unique: true
    add_index :platform_operators, :phone,                unique: true
    add_index :platform_operators, :status,               unique: true

    add_foreign_key :platform_operators, :companies, column: :company_id
    add_foreign_key :platform_operators, :users, column: :created_by_id
    add_foreign_key :platform_operators, :users, column: :updated_by_id
  end
end
