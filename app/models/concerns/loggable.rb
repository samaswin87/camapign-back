module Loggable
    extend ActiveSupport::Concern
    class_methods do
        def track_message_log
            has_many :logs, class_name: 'MessageLog', :as => :source
        end

        def track_message_status
            has_many :logs, class_name: 'MessageLog', :as => :integration
        end
    end
end
