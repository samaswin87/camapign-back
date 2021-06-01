class CreateWorkflowDepositories < ActiveRecord::Migration[6.1]
  def change
    create_table :workflow_depositories do |t|
      t.integer :status, default: 0
      t.integer :company_id
      t.string :keyword
      t.integer :no_of_contacts, default: 0
      t.string :phone
      t.boolean :default, default: false
      t.boolean :confidential, default: false

      t.integer :created_by_id
      t.integer :updated_by_id
      t.timestamps
    end

    add_index :workflow_depositories, :company_id,           unique: true
    add_index :workflow_depositories, :created_by_id,        unique: true
    add_index :workflow_depositories, :updated_by_id,        unique: true
    add_index :workflow_depositories, :keyword,              unique: true
    add_index :workflow_depositories, :phone,                unique: true
    add_index :workflow_depositories, :status,               unique: true
    
    add_foreign_key :workflow_depositories, :companies, column: :company_id
    add_foreign_key :workflow_depositories, :users, column: :created_by_id
    add_foreign_key :workflow_depositories, :users, column: :updated_by_id
  end
end
