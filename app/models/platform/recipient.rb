# frozen_string_literal: true

# Column      |              Type              | Collation | Nullable |                     Default
# -----------------+--------------------------------+-----------+----------+-------------------------------------------------
#  id              | bigint                         |           | not null | nextval('platform_recipients_id_seq'::regclass)
#  status          | integer                        |           |          | 0
#  phone           | character varying              |           |          |
#  archived_at     | timestamp without time zone    |           |          |
#  company_id      | integer                        |           |          |
#  email           | character varying              |           |          |
#  first_name      | character varying              |           |          |
#  last_name       | character varying              |           |          |
#  middle_name     | character varying              |           |          |
#  no_of_campaigns | character varying              |           |          | '0'::character varying
#  keywords        | character varying[]            |           |          | '{}'::character varying[]
#  notes           | text                           |           |          |
#  gender          | integer                        |           |          | 1
#  custom_fields   | jsonb                          |           |          | '{}'::jsonb
#  tags            | character varying[]            |           |          | '{}'::character varying[]
#  created_by_id   | integer                        |           |          |
#  updated_by_id   | integer                        |           |          |
#  created_at      | timestamp(6) without time zone |           | not null |
#  updated_at      | timestamp(6) without time zone |           | not null |
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

        belongs_to :company
        has_many :workflow_recipients, class_name: 'Workflow::Recipient'
        has_many :menu_recipients, class_name: 'Menu::Recipient'
        has_many :campaign_recipients, class_name: 'Campaign::Recipient'

        delegate :name, :to => :company, :prefix => true
        
        scope :status_by, ->(option) {
            recipients = Platform::Recipient.arel_table
            case option.to_s
            when /^active/
                self.active
            when /^inactive/
                self.inactive
            else
                raise(ArgumentError, "Invalid option: #{option}")
            end
        }

        scope :search_query, ->(query) {
            return nil  if query.blank?
            # condition query, parse into individual keywords
            terms = query.to_s.downcase.split(/\s+/)
            # replace "*" with "%" for wildcard searches,
            # append '%', remove duplicate '%'s
            terms = terms.map { |term|
                (term.gsub('*', '%') + '%').gsub(/%+/, '%')
            }
            # configure number of OR conditions for provision
            # of interpolation arguments. Adjust this if you
            # change the number of OR conditions.
            num_or_conditions = 5
            where(
            terms.map {
                or_clauses = [
                "LOWER(platform_recipients.first_name) LIKE ?",
                "LOWER(platform_recipients.last_name) LIKE ?",
                "LOWER(platform_recipients.middle_name) LIKE ?",
                "LOWER(platform_recipients.phone) LIKE ?",
                "LOWER(platform_recipients.email) LIKE ?"
                ].join(' OR ')
                "(#{ or_clauses })"
            }.join(' AND '),
            *terms.map { |term| [term] * num_or_conditions }.flatten
            )
        }

        scope :sorted_by, ->(sort_option) {
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

        scope :with_phone, ->(option_with_phone) {
            options = option_with_phone.split(' ')
            case options[0].to_s
            when 'start_with'
                where('phone LIKE ?', "#{options[1]}%")
            when 'end_with'
                where('phone LIKE ?', "%#{options[1]}")
            when 'equal'
                where(phone: options[1])
            when 'not_equal'
                where.not(phone: options[1])
            else
                raise(ArgumentError, "Invalid condition: #{options[0]}")
            end
        }

        scope :with_email, ->(option_with_email) {
            options = option_with_phone.split(' ')
            case options[0].to_s
            when 'start_with'
                where('email LIKE ?', "#{options[1]}%")
            when 'end_with'
                where('email LIKE ?', "%#{options[1]}")
            when 'equal'
                where(email: options[1])
            when 'not_equal'
                where.not(email: options[1])
            else
                raise(ArgumentError, "Invalid condition: #{options[0]}")
            end
        }

        scope :with_tags, ->(tags) {
            where("tags @> ARRAY[?]::varchar[]", tags)
        }

        scope :with_keywords, ->(keywords) {
            where("keywords @> ARRAY[?]::varchar[]", keywords)
        }
    end
end
