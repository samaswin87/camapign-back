# frozen_string_literal: true

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
end
