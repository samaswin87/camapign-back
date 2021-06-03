class CreateMenuPrompts < ActiveRecord::Migration[6.1]
  def change
    create_table :menu_prompts do |t|
      t.integer :depository_id
      t.text :body
      t.integer :order, default: 0
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end
    add_index :menu_prompts, :depository_id
    add_index :menu_prompts, :created_by_id
    add_index :menu_prompts, :updated_by_id

    add_foreign_key :menu_prompts, :menu_depositories, column: :depository_id
    add_foreign_key :menu_prompts, :users, column: :created_by_id
    add_foreign_key :menu_prompts, :users, column: :updated_by_id
  end
end
