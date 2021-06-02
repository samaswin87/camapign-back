class CreateWorkflowRecipients < ActiveRecord::Migration[6.1]
  def change
    create_table :workflow_recipients do |t|
      t.integer :depository_id
      t.integer :recipient_id
      t.integer :state, default: 0
      t.integer :progress, default: 0
      t.datetime :reply_at
      t.datetime :archived_at
      t.datetime :completed_at

      t.timestamps
    end

    add_index :workflow_recipients, :depository_id
    add_index :workflow_recipients, :recipient_id
    
    add_foreign_key :workflow_recipients, :workflow_depositories, column: :depository_id
    add_foreign_key :workflow_recipients, :platform_recipients, column: :recipient_id
  end
end
