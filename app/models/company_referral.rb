# frozen_string_literal: true

# Column     |              Type              | Collation | Nullable |                    Default
# ----------------+--------------------------------+-----------+----------+-----------------------------------------------
#  id             | bigint                         |           | not null | nextval('company_referrals_id_seq'::regclass)
#  company_id     | integer                        |           |          |
#  status         | integer                        |           |          | 0
#  name           | character varying              |           |          |
#  email          | character varying              |           |          |
#  phone          | character varying              |           |          |
#  description    | character varying              |           |          |
#  contact_person | character varying              |           |          |
#  referral_code  | character varying              |           |          |
#  free_credits   | integer                        |           |          | 0
#  created_at     | timestamp(6) without time zone |           | not null |
#  updated_at     | timestamp(6) without time zone |           | not null |
class CompanyReferral < ApplicationRecord
    enum status: [:referred, :joined, :completed]
    belongs_to :company
end
