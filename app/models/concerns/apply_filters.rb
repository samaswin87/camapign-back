module ApplyFilters
  extend ActiveSupport::Concern

  class_methods do
    def apply_filters(options = {})
      scope :status_by, ->(option) {
        return nil  if option.blank?
        case option.to_s
        when /^active/
            self.active
        when /^inactive/
            self.inactive
        else
            raise(ArgumentError, "Invalid option: #{option}")
        end
      }

      scope :with_company, ->(name) {
        return nil unless name.present?
        self.joins(:company).where('companies.name = ?', name)
      }

      scope :search_query, ->(query) {
        return nil  if query.blank?
        # condition query, parse into individual keywords
        terms = query.to_s.downcase.split(/\s+/)
        # replace "*" with "%" for wildcard searches,
        # append '%', remove duplicate '%'s
        terms = terms.map { |term|
            (term.gsub('*', '%') + '%').gsub(/%+/, '%')
        }

        clauses = options[:search][:clauses]
        # configure number of OR conditions for provision
        # of interpolation arguments. Adjust this if you
        # change the number of OR conditions.
        num_or_conditions = clauses.size
        condition = terms.map {
            or_clauses = clauses.join(' OR ')
            "(#{ or_clauses })"
        }.join(' AND ')
        if options[:search][:joins].present?
          joins(options[:search][:joins]).where(condition, *terms.map { |term| [term] * num_or_conditions }.flatten)
        else
          where(condition, *terms.map { |term| [term] * num_or_conditions }.flatten)
        end
      }

      options[:array_scopes].each do |scope|
        scope "with_#{scope}", ->(keyword) {
          return nil  if keyword.blank?
          keywords = keyword.split('_')
          where("#{scope} @> ARRAY[?]::varchar[]", keywords)
        }
      end

      options[:scopes].each do |scope|
        scope "with_#{scope}", ->(option_with_scope) {
          return nil  if option_with_scope.blank?
          options = option_with_scope.split('_eq_')
          case options[0].to_s
          when 'start_with'
              where("#{scope} LIKE ?", "#{options[1]}%")
          when 'end_with'
              where("#{scope} LIKE ?", "%#{options[1]}")
          when 'equal'
              where("#{scope}" => options[1])
          when 'not_equal'
              where.not("#{scope}" => options[1])
          else
              raise(ArgumentError, "Invalid condition: #{options[0]}")
          end
        }
      end
    end
  end

end