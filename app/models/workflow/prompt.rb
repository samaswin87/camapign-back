# frozen_string_literal: true

# Column     |              Type              | Collation | Nullable |                   Default
# ---------------+--------------------------------+-----------+----------+----------------------------------------------
#  id            | bigint                         |           | not null | nextval('workflow_prompts_id_seq'::regclass)
#  depository_id | integer                        |           |          |
#  body          | text                           |           |          |
#  order         | integer                        |           |          | 0
#  created_by_id | integer                        |           |          |
#  updated_by_id | integer                        |           |          |
#  created_at    | timestamp(6) without time zone |           | not null |
#  updated_at    | timestamp(6) without time zone |           | not null |
module Workflow
    class Prompt < WorkflowModel
        track_users

        belongs_to :depository, class_name: 'Workflow::Depository'
    end
end
