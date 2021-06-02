class CreateWorkflowCommunications < ActiveRecord::Migration[6.1]
  def change
    create_table :workflow_communications do |t|
      t.integer :status, default: 0
      t.integer :recipient_id
      t.string :message

      t.timestamps
    end

    add_index :workflow_communications, :recipient_id
    
    add_foreign_key :workflow_communications, :workflow_recipients, column: :recipient_id
  end
end
