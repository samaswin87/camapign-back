# frozen_string_literal: true

# Column     |              Type              | Collation | Nullable |                     Default
# ---------------+--------------------------------+-----------+----------+-------------------------------------------------
#  id            | bigint                         |           | not null | nextval('survey_depositories_id_seq'::regclass)
#  company_id    | integer                        |           |          |
#  status        | integer                        |           |          | 0
#  state         | character varying              |           |          | 
#  name          | character varying              |           |          |
#  description   | character varying              |           |          |
#  archived_at   | timestamp without time zone    |           |          |
#  published_at  | timestamp without time zone    |           |          |
#  unpublished_at| timestamp without time zone    |           |          |
#  created_by_id | integer                        |           |          |
#  updated_by_id | integer                        |           |          |
#  created_at    | timestamp(6) without time zone |           | not null |
#  updated_at    | timestamp(6) without time zone |           | not null |
module Survey
  class Depository < SurveyModel
    enum status: [:active, :inactive]
    enum state: [:draft, :published, :unpublished]
    validates :name, uniqueness: { scope: :company, message: "Name already exists!" }
    
    track_users
    act_as_state_tracker

    belongs_to :company
  end
end
