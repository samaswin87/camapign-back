# frozen_string_literal: true

# Column         |              Type                       | Collation | Nullable |              Default
# ------------------------+--------------------------------+-----------+----------+-----------------------------------
#  id                     | bigint                         |           | not null | nextval('users_id_seq'::regclass)
#  provider               | character varying              |           | not null | 'email'::character varying
#  uid                    | character varying              |           | not null | ''::character varying
#  encrypted_password     | character varying              |           | not null | ''::character varying
#  reset_password_token   | character varying              |           |          |
#  reset_password_sent_at | timestamp without time zone    |           |          |
#  allow_password_change  | boolean                        |           |          | false
#  remember_created_at    | timestamp without time zone    |           |          |
#  confirmation_token     | character varying              |           |          |
#  confirmed_at           | timestamp without time zone    |           |          |
#  confirmation_sent_at   | timestamp without time zone    |           |          |
#  unconfirmed_email      | character varying              |           |          |
#  failed_attempts        | integer                        |           | not null | 0
#  unlock_token           | character varying              |           |          |
#  locked_at              | timestamp without time zone    |           |          |
#  image                  | character varying              |           |          |
#  email                  | character varying              |           |          |
#  first_name             | character varying              |           | not null | ''::character varying
#  middle_name            | character varying              |           |          |
#  last_name              | character varying              |           | not null | ''::character varying
#  role                   | character varying              |           | not null | 'user'::character varying
#  tokens                 | json                           |           |          |
#  sign_in_count          | integer                        |           | not null | 0
#  current_sign_in_at     | timestamp without time zone    |           |          |
#  last_sign_in_at        | timestamp without time zone    |           |          |
#  current_sign_in_ip     | inet                           |           |          |
#  last_sign_in_ip        | inet                           |           |          |
#  company_id             | integer                        |           |          |
#  created_at             | timestamp(6) without time zone |           | not null |
#  updated_at             | timestamp(6) without time zone |           | not null |
class User < ActiveRecord::Base
  # issue: https://stackoverflow.com/questions/55626625/devise-token-auth-conflicts
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :timeoutable, :trackable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  belongs_to :company
  has_one :company
end
