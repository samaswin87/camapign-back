# frozen_string_literal: true

# Column      |              Type              | Collation | Nullable |                      Default
# -----------------+--------------------------------+-----------+----------+---------------------------------------------------
#  id              | bigint                         |           | not null | nextval('workflow_declarations_id_seq'::regclass)
#  depository_id   | integer                        |           |          |
#  body            | jsonb                          |           |          |
#  destination_url | character varying              |           |          |
#  created_at      | timestamp(6) without time zone |           | not null |
#  updated_at      | timestamp(6) without time zone |           | not null |
module Workflow
    class Declaration < WorkflowModel
    end
end
