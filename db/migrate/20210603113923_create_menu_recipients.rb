class CreateMenuRecipients < ActiveRecord::Migration[6.1]
  def change
    create_table :menu_recipients do |t|
      t.integer :depository_id
      t.integer :recipient_id
      t.integer :status, default: 0
      t.integer :progress, default: 0
      t.datetime :reply_at
      t.datetime :archived_at
      t.datetime :completed_at

      t.timestamps
    end

    add_index :menu_recipients, :depository_id
    add_index :menu_recipients, :recipient_id
    
    add_foreign_key :menu_recipients, :menu_depositories, column: :depository_id
    add_foreign_key :menu_recipients, :platform_recipients, column: :recipient_id
  end
end
