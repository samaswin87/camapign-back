class CampaignModel < ApplicationRecord
    self.abstract_class = true
    self.table_name_prefix = "campaign_"
    
end