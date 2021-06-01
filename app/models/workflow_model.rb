class WorkflowModel < ApplicationRecord
    self.abstract_class = true
    self.table_name_prefix = "workflow_"
end