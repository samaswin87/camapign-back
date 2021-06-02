# frozen_string_literal: true

# Column    |              Type              | Collation | Nullable |                       Default
# --------------+--------------------------------+-----------+----------+-----------------------------------------------------
#  id           | bigint                         |           | not null | nextval('workflow_communications_id_seq'::regclass)
#  status       | integer                        |           |          | 0
#  recipient_id | integer                        |           |          |
#  message      | character varying              |           |          |
#  created_at   | timestamp(6) without time zone |           | not null |
#  updated_at   | timestamp(6) without time zone |           | not null |
module Workflow
  class Communication < WorkflowModel
    enum status: [:draft, :sent, :received]

    belongs_to :recipient, class_name: 'Workflow::Recipient'
  end
end
