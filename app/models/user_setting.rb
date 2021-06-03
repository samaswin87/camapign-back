# frozen_string_literal: true
class UserSetting < ApplicationRecord

    has_one_attached :avatar
    belongs_to :user
end
