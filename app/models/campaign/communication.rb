# frozen_string_literal: true

# Column    |              Type              | Collation | Nullable |                       Default
# --------------+--------------------------------+-----------+----------+-----------------------------------------------------
#  id           | bigint                         |           | not null | nextval('campaign_communications_id_seq'::regclass)
#  recipient_id | integer                        |           |          |
#  message      | text                           |           |          |
#  delivery     | integer                        |           |          | 0
#  created_at   | timestamp(6) without time zone |           | not null |
#  updated_at   | timestamp(6) without time zone |           | not null |
module Campaign
  class Communication < CampaignModel
    enum delivery: [:outbound, :inbound, :voice_outbound, :voice_inbound]

    belongs_to :recipient, class_name: 'Campaign::Recipient'
  end
end
