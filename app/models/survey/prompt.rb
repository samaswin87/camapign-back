# frozen_string_literal: true

# Column     |              Type              | Collation | Nullable |                  Default
# ---------------+--------------------------------+-----------+----------+--------------------------------------------
#  id            | bigint                         |           | not null | nextval('survey_prompts_id_seq'::regclass)
#  depository_id | integer                        |           |          |
#  order         | integer                        |           |          | 0
#  description   | text                           |           |          |
#  choice1       | character varying              |           |          |
#  choice2       | character varying              |           |          |
#  choice3       | character varying              |           |          |
#  choice4       | character varying              |           |          |
#  choice5       | character varying              |           |          |
#  created_by_id | integer                        |           |          |
#  updated_by_id | integer                        |           |          |
#  created_at    | timestamp(6) without time zone |           | not null |
#  updated_at    | timestamp(6) without time zone |           | not null |
module Survey
  class Prompt < SurveyModel
    track_users
    
    belongs_to :depository, class_name: 'Survey::Depository'
  end
end