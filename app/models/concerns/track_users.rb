module TrackUsers
  extend ActiveSupport::Concern

  class_methods do
    def track_users
      belongs_to :created_by, optional: true, class_name: 'User'
      belongs_to :updated_by, optional: true, class_name: 'User'
    end
  end

end