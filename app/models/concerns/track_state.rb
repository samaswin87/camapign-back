module TrackState
  extend ActiveSupport::Concern

  class_methods do
    def act_as_state_tracker
      aasm whiny_transitions: false, column: 'state' do
        state :draft, initial: true
        state :published, :unpublished
    
        event :publish do
          transitions from: [:draft, :unpublished], to: :published
        end
    
        event :unpublish do
          transitions from: :published, to: :unpublished
        end
      end
    end
  end

end