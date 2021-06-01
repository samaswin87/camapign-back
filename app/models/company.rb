# frozen_string_literal: true

# Column      |              Type                    | Collation | Nullable |                Default
# ------------------+--------------------------------+-----------+----------+---------------------------------------
#  id               | bigint                         |           | not null | nextval('companies_id_seq'::regclass)
#  name             | character varying              |           |          |
#  email            | character varying              |           |          |
#  phone            | character varying              |           |          |
#  planCredit       | integer                        |           |          |
#  callForwarding   | boolean                        |           |          |
#  messageForward   | boolean                        |           |          |
#  totalCredits     | integer                        |           |          |
#  remainingCredits | integer                        |           |          |
#  creditPercentage | integer                        |           |          |
#  apiToken         | character varying              |           |          |
#  plan             | integer                        |           |          |
#  status           | integer                        |           |          |
#  created_at       | timestamp(6) without time zone |           | not null |
#  updated_at       | timestamp(6) without time zone |           | not null |
class Company < ApplicationRecord
    enum plan: [:tentative, :lite, :plus, :premium, :ultimate]
    enum status: [:active, :inactive]

    has_many :users
end
