# Column   |              Type              | Collation | Nullable |                   Default
# ------------+--------------------------------+-----------+----------+---------------------------------------------
#  id         | bigint                         |           | not null | nextval('twilio_settings_id_seq'::regclass)
#  sid        | character varying              |           |          |
#  token      | character varying              |           |          |
#  company_id | integer                        |           |          |
#  status     | integer                        |           |          | 0
#  created_at | timestamp(6) without time zone |           | not null |
#  updated_at | timestamp(6) without time zone |           | not null |
class TwilioSetting < ApplicationRecord
    enum status: [:active, :inactive]

    belongs_to :company

    def connect
        client = Twilio::REST::Client.new(self.sid, self.token)
        yield(client)
    end
end
