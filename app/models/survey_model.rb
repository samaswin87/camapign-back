class SurveyModel < ApplicationRecord
    self.abstract_class = true
    self.table_name_prefix = "survey_"
end