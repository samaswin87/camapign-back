class CreateWorkflowDeclarations < ActiveRecord::Migration[6.1]
  def change
    create_table :workflow_declarations do |t|
      t.integer :depository_id
      t.text :body
      t.string :destination_url

      t.integer :created_by_id
      t.integer :updated_by_id
      t.timestamps
    end
    add_index :workflow_declarations, :depository_id
    add_index :workflow_declarations, :created_by_id
    add_index :workflow_declarations, :updated_by_id

    add_foreign_key :workflow_declarations, :workflow_depositories, column: :depository_id
    add_foreign_key :workflow_declarations, :users, column: :created_by_id
    add_foreign_key :workflow_declarations, :users, column: :updated_by_id
  end
end