class CreateSurveyDepositories < ActiveRecord::Migration[6.1]
  def change
    create_table :survey_depositories do |t|
      t.integer :company_id
      t.integer :status, default: 0
      t.string :name
      t.string :description
      t.datetime  :archived_at
      t.integer :created_by_id
      t.integer :updated_by_id
      t.timestamps
    end

    add_index :survey_depositories, :company_id
    add_index :survey_depositories, :name
    add_index :survey_depositories, :created_by_id
    add_index :survey_depositories, :updated_by_id

    add_foreign_key :survey_depositories, :companies, column: :company_id
    add_foreign_key :survey_depositories, :users, column: :created_by_id
    add_foreign_key :survey_depositories, :users, column: :updated_by_id
  end
end
