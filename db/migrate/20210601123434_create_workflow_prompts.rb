class CreateWorkflowPrompts < ActiveRecord::Migration[6.1]
  def change
    create_table :workflow_prompts do |t|
      t.integer :depository_id
      t.text :body
      t.integer :order, default: 0
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end
    add_index :workflow_prompts, :depository_id
    add_index :workflow_prompts, :created_by_id
    add_index :workflow_prompts, :updated_by_id

    add_foreign_key :workflow_prompts, :workflow_depositories, column: :depository_id
    add_foreign_key :workflow_prompts, :users, column: :created_by_id
    add_foreign_key :workflow_prompts, :users, column: :updated_by_id
  end
end
