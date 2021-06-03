# frozen_string_literal: true

# Column    |              Type              | Collation | Nullable |                Default
# -------------+--------------------------------+-----------+----------+---------------------------------------
#  id          | bigint                         |           | not null | nextval('timelines_id_seq'::regclass)
#  user_id     | integer                        |           |          |
#  title       | character varying              |           |          |
#  description | character varying              |           |          |
#  created_at  | timestamp(6) without time zone |           | not null |
#  updated_at  | timestamp(6) without time zone |           | not null |
class Timeline < ApplicationRecord

    belongs_to :user
end
