# frozen_string_literal: true

# Column     |              Type              | Collation | Nullable |                     Default
# ---------------+--------------------------------+-----------+----------+-------------------------------------------------
#  id            | bigint                         |           | not null | nextval('menu_recipients_id_seq'::regclass)
#  depository_id | integer                        |           |          |
#  recipient_id  | integer                        |           |          |
#  status        | integer                        |           |          | 0
#  progress      | integer                        |           |          | 0
#  reply_at      | timestamp without time zone    |           |          |
#  archived_at   | timestamp without time zone    |           |          |
#  completed_at  | timestamp without time zone    |           |          |
#  created_at    | timestamp(6) without time zone |           | not null |
#  updated_at    | timestamp(6) without time zone |           | not null |
module Menu
    class Recipient < MenuModel
      enum status: [:started, :completed, :closed, :expired]
      LIFETIMES = { started: 24.hours, completed: 25.minutes }
  
      belongs_to :depository, class_name: 'Menu::Depository'
      belongs_to :platform_recipient, foreign_key: :recipient_id, class_name: 'Platform::Recipient'
      has_many :communications, class_name: 'Menu::Communication'
    end
  end
  