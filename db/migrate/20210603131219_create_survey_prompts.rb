class CreateSurveyPrompts < ActiveRecord::Migration[6.1]
  def change
    create_table :survey_prompts do |t|
      t.integer :depository_id
      t.integer :order, default: 0
      t.text :description
      t.string :choice1
      t.string :choice2
      t.string :choice3
      t.string :choice4
      t.string :choice5

      t.integer :created_by_id
      t.integer :updated_by_id
      t.timestamps
    end

    add_index :survey_prompts, :depository_id
    add_index :survey_prompts, :created_by_id
    add_index :survey_prompts, :updated_by_id

    add_foreign_key :survey_prompts, :survey_depositories, column: :depository_id
    add_foreign_key :survey_prompts, :users, column: :created_by_id
    add_foreign_key :survey_prompts, :users, column: :updated_by_id
  end
end
