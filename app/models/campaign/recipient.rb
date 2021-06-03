# frozen_string_literal: true

# Column     |              Type              | Collation | Nullable |                     Default
# ---------------+--------------------------------+-----------+----------+-------------------------------------------------
#  id            | bigint                         |           | not null | nextval('campaign_recipients_id_seq'::regclass)
#  status        | integer                        |           |          | 0
#  recipient_id  | integer                        |           |          |
#  depository_id | integer                        |           |          |
#  archived_at   | timestamp without time zone    |           |          |
#  data          | jsonb                          |           |          | '{}'::jsonb
#  created_at    | timestamp(6) without time zone |           | not null |
#  updated_at    | timestamp(6) without time zone |           | not null |
module Campaign
  class Recipient < CampaignModel
    enum status: [:draft, :replied]

    belongs_to :depository, class_name: 'Campaign::Depository'
    belongs_to :platform_recipient, foreign_key: :recipient_id, class_name: 'Platform::Recipient'
  end
end
