class CreateSurveyOutcomes < ActiveRecord::Migration[6.1]
  def change
    create_table :survey_outcomes do |t|
      t.integer :depository_id
      t.integer :prompt_id
      t.boolean :choice1, default: false
      t.boolean :choice2, default: false
      t.boolean :choice3, default: false
      t.boolean :choice4, default: false
      t.boolean :choice5, default: false
      t.integer :recipient_id

      t.timestamps
    end
    
    add_index :survey_outcomes, :depository_id
    add_index :survey_outcomes, :prompt_id
    add_index :survey_outcomes, :recipient_id

    add_foreign_key :survey_outcomes, :survey_depositories, column: :depository_id
    add_foreign_key :survey_outcomes, :survey_prompts, column: :prompt_id
    add_foreign_key :survey_outcomes, :platform_recipients, column: :recipient_id
  end
end
