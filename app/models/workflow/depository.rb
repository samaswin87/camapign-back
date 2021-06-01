# frozen_string_literal: true

# Column     |              Type              | Collation | Nullable |                      Default
# ----------------+--------------------------------+-----------+----------+---------------------------------------------------
#  id             | bigint                         |           | not null | nextval('workflow_depositories_id_seq'::regclass)
#  status         | integer                        |           |          |
#  company_id     | integer                        |           |          |
#  name           | character varying              |           |          |
#  no_of_contacts | integer                        |           |          |
#  phone          | character varying              |           |          |
#  confidential   | boolean                        |           |          |
#  created_at     | timestamp(6) without time zone |           | not null |
#  updated_at     | timestamp(6) without time zone |           | not null |
module Workflow
    class Depository < WorkflowModel
    end
end