# frozen_string_literal: true

# Column          |              Type              | Collation | Nullable |                  Default
# -------------------------+--------------------------------+-----------+----------+-------------------------------------------
#  id                      | bigint                         |           | not null | nextval('company_plans_id_seq'::regclass)
#  company_id              | integer                        |           |          |
#  month                   | character varying              |           |          |
#  credits                 | integer                        |           |          | 0
#  additional_credits      | integer                        |           |          | 0
#  inbounds                | integer                        |           |          | 0
#  outbounds               | integer                        |           |          | 0
#  voice_inbounds          | integer                        |           |          | 0
#  voice_outbounds         | integer                        |           |          | 0
#  availed_inbounds        | integer                        |           |          | 0
#  availed_outbounds       | integer                        |           |          | 0
#  availed_voice_inbounds  | integer                        |           |          | 0
#  availed_voice_outbounds | integer                        |           |          | 0
#  created_at              | timestamp(6) without time zone |           | not null |
#  updated_at              | timestamp(6) without time zone |           | not null |
class CompanyPlan < ApplicationRecord
    belongs_to :company
end
