class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  include AASM
  include TrackUsers
  include DisplayTimestamp
  include ApplyFilters
  include TrackState
end
