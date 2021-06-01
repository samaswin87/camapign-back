# frozen_string_literal: true

# Column     |              Type              | Collation | Nullable |                       Default
# ---------------+--------------------------------+-----------+----------+-----------------------------------------------------
#  id            | bigint                         |           | not null | nextval('workflow_communications_id_seq'::regclass)
#  depository_id | integer                        |           |          |
#  body          | jsonb                          |           |          |
#  name          | character varying              |           |          |
#  default       | character varying              |           |          |
#  order         | integer                        |           |          |
#  created_at    | timestamp(6) without time zone |           | not null |
#  updated_at    | timestamp(6) without time zone |           | not null |
module Workflow
    class Communication < WorkflowModel
    end
end
