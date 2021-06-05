module DisplayTimestamp
  extend ActiveSupport::Concern

  included do
    def created_on
      created_at.try(:to_display)
    end

    def updated_on
      updated_at.try(:to_display)
    end

    def archived_on
      archived_at.try(:to_display)
    end
  end

end