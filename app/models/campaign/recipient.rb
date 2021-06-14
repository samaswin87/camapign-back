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
    serialize :data, Hash

    apply_filters  scopes: [:name], 
    search: { joins: :platform_recipient, clauses: [
      "LOWER(platform_recipients.phone) LIKE ?"
    ]},
    enum_scopes: [:status],
    sort: {fields: [:created_at]},
    names: [
      :sorted_by,
      :search_query,
      :status_with
    ]


    belongs_to :depository, class_name: 'Campaign::Depository'
    belongs_to :platform_recipient, foreign_key: :recipient_id, class_name: 'Platform::Recipient'
    has_many :communications, class_name: 'Campaign::Communication'
  end
end
