class PlatformModel < ApplicationRecord
    self.abstract_class = true
    self.table_name_prefix = "platform_"
    
end