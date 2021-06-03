class CreateCampaignRecipients < ActiveRecord::Migration[6.1]
  def change
    create_table :campaign_recipients do |t|

      t.timestamps
    end
  end
end
