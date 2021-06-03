class MenuModel < ApplicationRecord
    self.abstract_class = true
    self.table_name_prefix = "menu_"
end