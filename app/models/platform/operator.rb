# frozen_string_literal: true

# Column     |              Type              | Collation | Nullable |                    Default
# ---------------+--------------------------------+-----------+----------+------------------------------------------------
#  id            | bigint                         |           | not null | nextval('platform_operators_id_seq'::regclass)
#  status        | integer                        |           |          | 0
#  phone         | character varying              |           |          |
#  archived_at   | timestamp without time zone    |           |          |
#  company_id    | integer                        |           |          |
#  name          | character varying              |           |          |
#  short_code    | boolean                        |           |          | false
#  created_by_id | integer                        |           |          |
#  updated_by_id | integer                        |           |          |
#  created_at    | timestamp(6) without time zone |           | not null |
#  updated_at    | timestamp(6) without time zone |           | not null |
module Platform
  class Operator < PlatformModel
    enum status: [:active, :inactive]
    track_users

    belongs_to :company
  end
end