class CreateCampaignCommunications < ActiveRecord::Migration[6.1]
  def change
    create_table :campaign_communications do |t|
      t.integer :recipient_id
      t.text :message
      t.integer :delivery, default: 0

      t.timestamps
    end

    add_index :campaign_communications, :recipient_id
    
    add_foreign_key :campaign_communications, :campaign_recipients, column: :recipient_id
  end
end
