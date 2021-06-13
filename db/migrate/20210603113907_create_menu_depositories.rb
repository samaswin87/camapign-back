class CreateMenuDepositories < ActiveRecord::Migration[6.1]
  def change
    create_table :menu_depositories do |t|
      t.integer :status, default: 0
      t.string :state
      t.integer :company_id
      t.string :keyword
      t.integer :no_of_contacts, default: 0
      t.integer :operator_id
      t.boolean :default, default: false
      t.boolean :confidential, default: false
      t.datetime  :archived_at
      t.datetime  :published_at
      t.datetime  :unpublished_at

      t.integer :created_by_id
      t.integer :updated_by_id
      t.timestamps
    end

    add_index :menu_depositories, :company_id
    add_index :menu_depositories, :operator_id
    add_index :menu_depositories, :created_by_id
    add_index :menu_depositories, :updated_by_id
    add_index :menu_depositories, :keyword
    add_index :menu_depositories, :status
    
    add_foreign_key :menu_depositories, :platform_operators, column: :operator_id
    add_foreign_key :menu_depositories, :companies, column: :company_id
    add_foreign_key :menu_depositories, :users, column: :created_by_id
    add_foreign_key :menu_depositories, :users, column: :updated_by_id
  end
end
