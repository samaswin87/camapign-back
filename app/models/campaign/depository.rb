# frozen_string_literal: true

# Column     |              Type              | Collation | Nullable |                      Default
# ----------------+--------------------------------+-----------+----------+---------------------------------------------------
#  id             | bigint                         |           | not null | nextval('campaign_depositories_id_seq'::regclass)
#  status         | integer                        |           |          | 0
#  company_id     | integer                        |           |          |
#  no_of_contacts | integer                        |           |          | 0
#  operator_id    | integer                        |           |          |
#  name           | character varying              |           |          |
#  message        | text                           |           |          |
#  group          | integer                        |           |          | 0
#  scheduled_at   | timestamp without time zone    |           |          |
#  recurring_at   | time without time zone         |           |          |
#  recurring_days | character varying[]            |           |          | '{}'::character varying[]
#  created_by_id  | integer                        |           |          |
#  updated_by_id  | integer                        |           |          |
#  created_at     | timestamp(6) without time zone |           | not null |
#  updated_at     | timestamp(6) without time zone |           | not null |
module Campaign
  class Depository < CampaignModel
    enum status: [:active, :inactive]
    enum group: [:immediate, :recurring, :scheduled]
    track_users

    RECURRING_DAYS = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']

    belongs_to :company
    belongs_to :operator, class_name: 'Platform::Operator'
    has_many :recipients, class_name: 'Campaign::Recipient'
    has_many :communications, through: :recipients

    attribute :company_name, :string
    attribute :created_on, :string
  end
end
