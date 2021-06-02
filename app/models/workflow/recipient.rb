# frozen_string_literal: true

# Column     |              Type              | Collation | Nullable |                     Default
# ---------------+--------------------------------+-----------+----------+-------------------------------------------------
#  id            | bigint                         |           | not null | nextval('workflow_recipients_id_seq'::regclass)
#  depository_id | integer                        |           |          |
#  recipient_id  | integer                        |           |          |
#  state         | integer                        |           |          |
#  progress      | integer                        |           |          |
#  reply_at      | timestamp without time zone    |           |          |
#  archived_at   | timestamp without time zone    |           |          |
#  completed_at  | timestamp without time zone    |           |          |
#  created_at    | timestamp(6) without time zone |           | not null |
#  updated_at    | timestamp(6) without time zone |           | not null |
module Workflow
  class Recipient < WorkflowModel

    belongs_to :depository, class_name: 'Workflow::Depository'
    belongs_to :platform_recipient, foreign_key: :recipient_id, class_name: 'Platform::Recipient'
  end
end