# frozen_string_literal: true

# Column    |              Type              | Collation | Nullable |             Default
# -------------+--------------------------------+-----------+----------+----------------------------------
#  id          | bigint                         |           | not null | nextval('tags_id_seq'::regclass)
#  company_id  | integer                        |           |          |
#  status      | integer                        |           |          | 0
#  name        | character varying              |           |          |
#  archived_at | timestamp without time zone    |           |          |
#  created_at  | timestamp(6) without time zone |           | not null |
#  updated_at  | timestamp(6) without time zone |           | not null |
class Tag < ApplicationRecord
    enum status: [:active, :inactive]
    belongs_to :company

end
