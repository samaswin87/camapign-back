# Column      |              Type              | Collation | Nullable |                 Default
# ------------------+--------------------------------+-----------+----------+------------------------------------------
#  id               | bigint                         |           | not null | nextval('message_logs_id_seq'::regclass)
#  code             | character varying              |           |          |
#  message          | text                           |           |          |
#  status           | integer                        |           |          | 0
#  source_type      | character varying              |           | not null |
#  source_id        | bigint                         |           | not null |
#  integration_type | character varying              |           | not null |
#  integration_id   | bigint                         |           | not null |
#  created_at       | timestamp(6) without time zone |           | not null |
#  updated_at       | timestamp(6) without time zone |           | not null |
class MessageLog < ApplicationRecord
    enum status: [:success, :fail]
    belongs_to :source, polymorphic: true
    belongs_to :integration, polymorphic: true


end
