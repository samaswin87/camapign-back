# frozen_string_literal: true

# Column      |              Type              | Collation | Nullable |                     Default
# -----------------+--------------------------------+-----------+----------+-------------------------------------------------
#  id              | bigint                         |           | not null | nextval('platform_recipients_id_seq'::regclass)
#  status          | integer                        |           |          | 0
#  phone           | character varying              |           |          |
#  archived_at     | timestamp without time zone    |           |          |
#  company_id      | integer                        |           |          |
#  email           | character varying              |           |          |
#  first_name      | character varying              |           |          |
#  last_name       | character varying              |           |          |
#  middle_name     | character varying              |           |          |
#  no_of_campaigns | character varying              |           |          | '0'::character varying
#  keywords        | character varying[]            |           |          | '{}'::character varying[]
#  notes           | text                           |           |          |
#  gender          | integer                        |           |          | 1
#  custom_fields   | jsonb                          |           |          | '{}'::jsonb
#  tags            | character varying[]            |           |          | '{}'::character varying[]
#  created_by_id   | integer                        |           |          |
#  updated_by_id   | integer                        |           |          |
#  created_at      | timestamp(6) without time zone |           | not null |
#  updated_at      | timestamp(6) without time zone |           | not null |
module Platform
    class Recipient < PlatformModel
        enum status: [:active, :inactive]
        track_users

        belongs_to :company
        has_many :workflow_recipients, class_name: 'Workflow::Recipient'

        attribute :company_name
    end
end
