# frozen_string_literal: true

# Column       |              Type              | Collation | Nullable |                  Default
# --------------------+--------------------------------+-----------+----------+-------------------------------------------
#  id                 | bigint                         |           | not null | nextval('user_settings_id_seq'::regclass)
#  user_id            | integer                        |           |          |
#  notify_workflow    | boolean                        |           |          | false
#  notify_menu        | boolean                        |           |          | false
#  notify_campaign    | boolean                        |           |          | false
#  notify_creditlimit | boolean                        |           |          | false
#  time_zone          | character varying              |           |          | 'UTC'::character varying
#  created_at         | timestamp(6) without time zone |           | not null |
#  updated_at         | timestamp(6) without time zone |           | not null |
class UserSetting < ApplicationRecord

    has_one_attached :avatar
    belongs_to :user
end
