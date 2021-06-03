# frozen_string_literal: true

# Column     |              Type              | Collation | Nullable |                   Default
# ---------------+--------------------------------+-----------+----------+---------------------------------------------
#  id            | bigint                         |           | not null | nextval('survey_outcomes_id_seq'::regclass)
#  depository_id | integer                        |           |          |
#  prompt_id     | integer                        |           |          |
#  choice1       | boolean                        |           |          | false
#  choice2       | boolean                        |           |          | false
#  choice3       | boolean                        |           |          | false
#  choice4       | boolean                        |           |          | false
#  choice5       | boolean                        |           |          | false
#  recipient_id  | integer                        |           |          |
#  created_at    | timestamp(6) without time zone |           | not null |
#  updated_at    | timestamp(6) without time zone |           | not null |
module Survey
  class Outcome < SurveyModel

    belongs_to :depository, class_name: 'Survey::Depository'
    belongs_to :recipient, class_name: 'Survey::Recipient'
    belongs_to :prompt, class_name: 'Survey::Prompt'
  end
end
