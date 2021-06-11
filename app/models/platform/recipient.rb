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
        filterrific(
            default_filter_params: { sorted_by: 'created_at_desc' },
            available_filters: [
                :sorted_by,
                :search_query,
                :with_phone,
                :with_email,
                :with_tags,
                :with_keywords,
                :status_by
            ]
        )
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
        array_scopes: [:tags, :keywords]

        belongs_to :company
        has_many :workflow_recipients, class_name: 'Workflow::Recipient'
        has_many :menu_recipients, class_name: 'Menu::Recipient'
        has_many :campaign_recipients, class_name: 'Campaign::Recipient'

        scope :sorted_by, ->(sort_option) {
            return nil  if sort_option.blank?
            # extract the sort direction from the param value.
            direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
            recipients = Platform::Recipient.arel_table
            company = Company.arel_table
            case sort_option.to_s
            when /^created_at_/
                # order("recipients.created_at #{direction}")
                order(recipients[:created_at].send(direction))
            when /^phone_/
                # order("recipients.phone #{direction}")
                order(recipients[:phone].send(direction))
            when /^email_/
                # order("recipients.email #{direction}")
                order(recipients[:email].send(direction))
            when /^name_/
                # order("LOWER(recipients.last_name) #{direction}, LOWER(recipients.first_name) #{direction}")
                order(recipients[:last_name].lower.send(direction)).order(recipients[:first_name].lower.send(direction))
            when /^company_name_/
                # order("LOWER(company.name) #{ direction }").includes(:company)
                Platform::Recipient.joins(:company).order(company[:name].lower.send(direction)).order(recipients[:last_name].lower.send(direction))
            else
                raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
            end
        }
    end
end
