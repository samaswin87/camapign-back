# frozen_string_literal: true

# Column    |              Type              | Collation | Nullable |                  Default
# -------------+--------------------------------+-----------+----------+-------------------------------------------
#  id          | bigint                         |           | not null | nextval('access_rights_id_seq'::regclass)
#  module_name | character varying              |           |          |
#  create      | boolean                        |           |          | false
#  show        | boolean                        |           |          | false
#  list        | boolean                        |           |          | false
#  edit        | boolean                        |           |          | false
#  menu        | boolean                        |           |          | false
#  logo        | character varying              |           |          |
#  source_type | character varying              |           | not null |
#  source_id   | bigint                         |           | not null |
#  created_at  | timestamp(6) without time zone |           | not null |
#  updated_at  | timestamp(6) without time zone |           | not null |
class AccessRight < ApplicationRecord
  belongs_to :source, polymorphic: true
end
