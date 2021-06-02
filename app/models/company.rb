# frozen_string_literal: true

# Column       |              Type              | Collation | Nullable |                Default
# -------------------+--------------------------------+-----------+----------+---------------------------------------
#  id                | bigint                         |           | not null | nextval('companies_id_seq'::regclass)
#  name              | character varying              |           | not null |
#  email             | character varying              |           | not null |
#  phone             | character varying              |           | not null |
#  plan_credits      | integer                        |           |          | 0
#  call_forwarding   | boolean                        |           |          | false
#  message_forward   | boolean                        |           |          | false
#  total_credits     | integer                        |           |          | 0
#  remaining_credits | integer                        |           |          | 0
#  credit_percentage | integer                        |           |          | 0
#  api_token         | character varying              |           |          |
#  plan              | integer                        |           |          | 1
#  status            | integer                        |           |          | 0
#  created_at        | timestamp(6) without time zone |           | not null |
#  updated_at        | timestamp(6) without time zone |           | not null |
class Company < ApplicationRecord
    enum plan: [:tentative, :lite, :plus, :premium, :ultimate]
    enum status: [:active, :inactive]

    has_many :users
end
