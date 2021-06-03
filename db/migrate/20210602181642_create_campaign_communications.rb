class CreateCampaignCommunications < ActiveRecord::Migration[6.1]
  def change
    create_table :campaign_communications do |t|

      t.timestamps
    end
  end
end
