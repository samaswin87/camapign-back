class Company < ApplicationRecord
    enum plan: [:tentative, :lite, :plus, :premium, :ultimate]
    enum status: [:active, :inactive]

    has_many :users
end
