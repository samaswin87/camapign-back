# frozen_string_literal: true

# Column       |              Type              | Collation | Nullable |                     Default
# -------------------+--------------------------------+-----------+----------+-------------------------------------------------
#  id                | bigint                         |           | not null | nextval('platform_recipients_id_seq'::regclass)
#  status            | integer                        |           |          | 0
#  country_code      | character varying              |           |          | 'US'::character varying
#  country_extension | character varying              |           |          |
#  phone             | character varying              |           |          |
#  archived_at       | timestamp without time zone    |           |          |
#  company_id        | integer                        |           |          |
#  email             | character varying              |           |          |
#  first_name        | character varying              |           |          |
#  last_name         | character varying              |           |          |
#  middle_name       | character varying              |           |          |
#  no_of_campaigns   | character varying              |           |          | '0'::character varying
#  keywords          | character varying[]            |           |          | '{}'::character varying[]
#  notes             | text                           |           |          |
#  gender            | integer                        |           |          | 1
#  custom_fields     | jsonb                          |           |          | '{}'::jsonb
#  tags              | character varying[]            |           |          | '{}'::character varying[]
#  created_by_id     | integer                        |           |          |
#  updated_by_id     | integer                        |           |          |
#  created_at        | timestamp(6) without time zone |           | not null |
#  updated_at        | timestamp(6) without time zone |           | not null |
module Platform
    class Recipient < PlatformModel
        enum status: [:active, :inactive]
        track_users
        apply_filters scopes: [:phone, :email], 
        search: { clauses: [
            "LOWER(platform_recipients.first_name) LIKE ?",
            "LOWER(platform_recipients.last_name) LIKE ?",
            "LOWER(platform_recipients.middle_name) LIKE ?",
            "LOWER(platform_recipients.phone) LIKE ?",
            "LOWER(platform_recipients.email) LIKE ?"
        ]},
        array_scopes: [:tags, :keywords],
        enum_scopes: [:status],
        sort: {fields: [:created_at, :phone, :email, :first_name, :last_name, :company_name], company: [:last_name]},
        names: [
            :sorted_by,
            :search_query,
            :with_phone,
            :with_email,
            :with_tags,
            :with_keywords,
            :status_with
        ]

        belongs_to :company
        has_many :workflow_recipients, class_name: 'Workflow::Recipient'
        has_many :menu_recipients, class_name: 'Menu::Recipient'
        has_many :campaign_recipients, class_name: 'Campaign::Recipient'
    end
end
