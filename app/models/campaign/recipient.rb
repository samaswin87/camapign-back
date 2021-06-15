# frozen_string_literal: true

# Column     |              Type              | Collation | Nullable |                     Default
# ---------------+--------------------------------+-----------+----------+-------------------------------------------------
#  id            | bigint                         |           | not null | nextval('campaign_recipients_id_seq'::regclass)
#  status        | integer                        |           |          | 0
#  state         | character varying              |           |          |
#  recipient_id  | integer                        |           |          |
#  depository_id | integer                        |           |          |
#  archived_at   | timestamp without time zone    |           |          |
#  data          | jsonb                          |           |          | '{}'::jsonb
#  created_at    | timestamp(6) without time zone |           | not null |
#  updated_at    | timestamp(6) without time zone |           | not null |
module Campaign
  class Recipient < CampaignModel
    enum status: [:active, :inactive]

    aasm whiny_transitions: false, column: 'state' do
      state :draft, initial: true
      state :delivered, :received
  
      event :sent do
        transitions from: :draft, to: :delivered
      end
  
      event :receive do
        transitions from: :draft, to: :received
      end
    end

    apply_filters  scopes: [:phone], 
    search: { joins: :platform_recipient, clauses: [
      "LOWER(platform_recipients.phone) LIKE ?"
    ]},
    enum_scopes: [:status, :state],
    sort: {fields: [:created_at]},
    names: [
      :sorted_by,
      :search_query,
      :status_with,
      :with_phone,
      :with_tags,
      :with_data_keys,
      :with_data
    ]


    scope :with_phone, ->(option_with_phone) {
      return nil  if option_with_phone.blank?
      options = option_with_phone.split(',')
      case options[0].to_s
      when 'start_with'
          joins(:platform_recipient).where('platform_recipients.phone LIKE ?', "#{options[1]}%")
      when 'end_with'
          joins(:platform_recipient).where('platform_recipients.phone LIKE ?', "%#{options[1]}")
      when 'equal'
          joins(:platform_recipient).where('platform_recipients.phone = ?', options[1])
      when 'not_equal'
          joins(:platform_recipient).where.not('platform_recipients.phone = ?', options[1])
      else
          raise(ArgumentError, "Invalid condition: #{options[0]}")
      end
    }

    scope :with_tags, ->(keyword) {
      return nil if keyword.blank?
      keywords = keyword.split(',')
      joins(:platform_recipient).where("platform_recipients.tags @> ARRAY[?]::varchar[]", keywords)
    }

    scope :with_data, ->(key_with_value) {
      return nil if key_with_value.blank?
      keywords = key_with_value.split(',')
      return nil if keywords.size <= 1

      where("LOWER(data::text)::jsonb @> ?", {"#{keywords[0]}": keywords[1]}.to_json)
    }

    scope :with_data_keys, ->(key) {
      return nil if key.blank?
      keys = key.split(',')
      where("data?& array[:keys]", keys: keys)
    }

    belongs_to :depository, class_name: 'Campaign::Depository'
    belongs_to :platform_recipient, foreign_key: :recipient_id, class_name: 'Platform::Recipient'
    has_many :communications, class_name: 'Campaign::Communication'
  end
end
