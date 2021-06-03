# frozen_string_literal: true

# Column           |              Type              | Collation | Nullable |                   Default
# ----------------------------+--------------------------------+-----------+----------+----------------------------------------------
#  id                         | bigint                         |           | not null | nextval('company_settings_id_seq'::regclass)
#  address                    | text                           |           |          |
#  batch_process_default_time | character varying              |           |          | '12:00 AM UTC'::character varying
#  time_zone                  | character varying              |           |          | 'UTC'::character varying
#  company_id                 | integer                        |           |          |
#  message_length             | integer                        |           |          | 0
#  maxuser                    | integer                        |           |          | 0
#  max_campaign               | integer                        |           |          | 0
#  max_workflow               | integer                        |           |          | 0
#  max_menu                   | integer                        |           |          | 0
#  max_contacts_in_campaign   | integer                        |           |          | 0
#  use_short_code             | boolean                        |           |          | false
#  use_destination_link       | boolean                        |           |          | false
#  notify_credit_limit        | boolean                        |           |          | false
#  notify_user_creation       | boolean                        |           |          | false
#  notify_campaign_creation   | boolean                        |           |          | false
#  notify_workflow_creation   | boolean                        |           |          | false
#  notify_menu_creation       | boolean                        |           |          | false
#  sso                        | boolean                        |           |          | false
#  import_workflows           | boolean                        |           |          | false
#  import_menus               | boolean                        |           |          | false
#  import_users               | boolean                        |           |          | false
#  import_contacts            | boolean                        |           |          | false
#  import_campaigns           | boolean                        |           |          | false
#  plan_start_date            | date                           |           |          | 
#  plan_end_date              | date                           |           |          |
#  updated_by_id              | integer                        |           |          |
#  created_at                 | timestamp(6) without time zone |           | not null |
#  updated_at                 | timestamp(6) without time zone |           | not null |
class CompanySetting < ApplicationRecord
    has_one_attached :logo
    belongs_to :updated_by, class_name: 'User'
    belongs_to :company
end
