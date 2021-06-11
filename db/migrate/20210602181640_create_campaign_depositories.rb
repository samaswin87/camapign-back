class CreateCampaignDepositories < ActiveRecord::Migration[6.1]
  def change
    create_table :campaign_depositories do |t|
      t.integer :status, default: 0
      t.integer :company_id
      t.integer :no_of_contacts, default: 0
      t.integer :operator_id
      t.string :name
      t.text :message
      t.integer :group, default: 0
      t.datetime :scheduled_at
      t.time :recurring_at
      t.datetime  :archived_at
      t.string :recurring_days, array: true, default: []
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end

    add_index :campaign_depositories, :company_id
    add_index :campaign_depositories, :operator_id
    add_index :campaign_depositories, :created_by_id
    add_index :campaign_depositories, :updated_by_id
    add_index :campaign_depositories, :name,              unique: true
    add_index :campaign_depositories, :status
    add_index :campaign_depositories, :group
    
    add_foreign_key :campaign_depositories, :companies, column: :company_id
    add_foreign_key :campaign_depositories, :platform_operators, column: :operator_id
  end
end
