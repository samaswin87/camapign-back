module CoreExtensions
  module Time
    module Display
      def to_display
        self.strftime("%d-%b-%Y")
      end
    end
  end
end

Time.include CoreExtensions::Time::Display