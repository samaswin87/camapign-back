class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  include TrackUsers
  include DisplayTimestamp
  include ApplyFilters
end
