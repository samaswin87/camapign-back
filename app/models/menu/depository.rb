# frozen_string_literal: true

# Column     |              Type              | Collation | Nullable |                    Default
# ----------------+--------------------------------+-----------+----------+-----------------------------------------------
#  id             | bigint                         |           | not null | nextval('menu_depositories_id_seq'::regclass)
#  status         | integer                        |           |          | 0
#  state          | character varying              |           |          | 
#  company_id     | integer                        |           |          |
#  keyword        | character varying              |           |          |
#  no_of_contacts | integer                        |           |          | 0
#  operator_id    | integer                        |           |          |
#  default        | boolean                        |           |          | false
#  confidential   | boolean                        |           |          | false
#  archived_at    | timestamp without time zone    |           |          |
#  published_at   | timestamp without time zone    |           |          |
#  unpublished_at | timestamp without time zone    |           |          |
#  created_by_id  | integer                        |           |          |
#  updated_by_id  | integer                        |           |          |
#  created_at     | timestamp(6) without time zone |           | not null |
#  updated_at     | timestamp(6) without time zone |           | not null |
module Menu
  class Depository < MenuModel
      enum status: [:active, :inactive]
      enum state: [:draft, :published, :unpublished]
      validates :keyword, uniqueness: { scope: :company, message: "Name already exists!" }

      track_users
      act_as_state_tracker
      
      belongs_to :company
      belongs_to :operator, class_name: 'Platform::Operator'
      has_one :declaration, class_name: 'Menu::Declaration'
      has_many :recipients, class_name: 'Menu::Recipient'
      has_many :communications, through: :recipients
  end
end