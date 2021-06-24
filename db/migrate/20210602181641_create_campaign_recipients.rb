class CreateCampaignRecipients < ActiveRecord::Migration[6.1]
  def change
    create_table :campaign_recipients do |t|
      t.integer :status, default: 0
      t.string :state
      t.integer :recipient_id
      t.integer :depository_id
      t.datetime :archived_at
      
      t.timestamps
    end
  end
end
