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
#  archived_at    | timestamp without time zone    |           |          |
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
    apply_filters  scopes: [:name], search: { joins: :operator, clauses: [
      "LOWER(campaign_depositories.name) LIKE ?",
      "LOWER(campaign_depositories.message) LIKE ?",
      "LOWER(platform_operators.phone) LIKE ?"
    ]}

    RECURRING_DAYS = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']

    belongs_to :company
    belongs_to :operator, class_name: 'Platform::Operator'
    has_many :recipients, class_name: 'Campaign::Recipient'
    has_many :communications, through: :recipients

    scope :sorted_by, ->(sort_option) {
      return nil  if sort_option.blank?
      # extract the sort direction from the param value.
      direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
      depositories = Campaign::Depository.arel_table
      company = Company.arel_table
      case sort_option.to_s
      when /^created_at_/
        order(depositories[:created_at].send(direction))
      when /^scheduled_at_/
        order(depositories[:scheduled_at].send(direction))
      when /^recurring_at_/
        order(depositories[:recurring_at].send(direction))
      when /^phone_/
        order(depositories[:phone].send(direction))
      when /^group_/
        order(depositories[:group].send(direction))
      when /^name_/
        order(depositories[:name].lower.send(direction))
      when /^company_name_/
        Campaign::Depository.joins(:company).order(company[:name].lower.send(direction)).order(depositories[:name].lower.send(direction))
      else
        raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
      end
    }

    scope :with_group, ->(option) {
      return nil  if option.blank?
      case option.to_s
      when 'immediate'
        self.immediate
      when 'recurring'
        self.recurring
      when 'scheduled'
        self.scheduled
      else
          raise(ArgumentError, "Invalid condition: #{option}")
      end
    }

    scope :with_recurring_days, ->(option) {
      return nil unless option.present? && RECURRING_DAYS.include?(option)
      where("recurring_days @> ARRAY[?]::varchar[]", [option])
    }

  end
end
