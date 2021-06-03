# frozen_string_literal: true
class CompanySetting < ApplicationRecord
    has_one_attached :logo
    belongs_to :updated_by, class_name: 'User'
    belongs_to :company
end
