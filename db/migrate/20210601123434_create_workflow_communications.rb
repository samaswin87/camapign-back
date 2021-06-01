class CreateWorkflowCommunications < ActiveRecord::Migration[6.1]
  def change
    create_table :workflow_communications do |t|
      t.integer :depository_id
      t.text :body
      t.integer :order, default: 0

      t.timestamps
    end
    add_index :workflow_communications, :depository_id,           unique: true
    add_foreign_key :workflow_communications, :workflow_depositories, column: :depository_id
  end
end
