# frozen_string_literal: true

# Column      |              Type              | Collation | Nullable |                      Default
# -----------------+--------------------------------+-----------+----------+---------------------------------------------------
#  id              | bigint                         |           | not null | nextval('menu_declarations_id_seq'::regclass)
#  depository_id   | integer                        |           |          |
#  body            | text                           |           |          |
#  destination_url | character varying              |           |          |
#  created_by_id   | integer                        |           |          |
#  updated_by_id   | integer                        |           |          |
#  created_at      | timestamp(6) without time zone |           | not null |
#  updated_at      | timestamp(6) without time zone |           | not null |
module Menu
  class Declaration < MenuModel
    track_users
        
    belongs_to :depository, class_name: 'Menu::Depository'
    has_many :recipients, class_name: 'Platform::Recipient'
  end
end
