module ApplyFilters
  extend ActiveSupport::Concern

  class_methods do
    def apply_filters(options = {})

      filterrific(
        default_filter_params: { sorted_by: 'created_at_desc' },
        available_filters: options[:names] || []
      )
      (options[:enum_scopes] || []).each do |enum_scope|
        scope "#{enum_scope}_with", ->(option) {
          return nil unless option.present?
          
          enum_details = self.send("#{enum_scope.to_s.pluralize}")
          return nil unless enum_details.present?

          if enum_details.keys.include?(option)
            self.send("#{option}")
          else
            raise(ArgumentError, "Invalid option: #{option}")
          end
        }
      end

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
        option_search = options[:search] || {}
        clauses = option_search[:clauses]
        # configure number of OR conditions for provision
        # of interpolation arguments. Adjust this if you
        # change the number of OR conditions.
        num_or_conditions = clauses.size
        condition = terms.map {
            or_clauses = clauses.join(' OR ')
            "(#{ or_clauses })"
        }.join(' AND ')
        if option_search[:joins].present?
          joins(option_search[:joins]).where(condition, *terms.map { |term| [term] * num_or_conditions }.flatten)
        else
          where(condition, *terms.map { |term| [term] * num_or_conditions }.flatten)
        end
      }

      scope :sorted_by, ->(sort_option) {
        return nil if sort_option.blank?
        # extract the sort direction from the param value.
        direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
        option_sort = options[:sort] || {}
        records = self.arel_table
        company = Company.arel_table if option_sort[:company]
        sort_field = (option_sort[:fields] || []).map {|field| field if "#{field}_#{direction}" == sort_option.to_s }
        if sort_field.compact.first
          if company && sort_field.compact.first.to_s == 'company_name'
            self.joins(:company).order(company[:name].lower.send(direction)).order(records[option_sort[:company].first].lower.send(direction))
          else
            order(records[sort_field.compact.first].send(direction))
          end
        else
          raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
        end
      }

      (options[:array_scopes] || []).each do |scope|
        scope "with_#{scope}", ->(keyword) {
          return nil  if keyword.blank?
          keywords = keyword.split('_')
          where("#{scope} @> ARRAY[?]::varchar[]", keywords)
        }
      end

      (options[:scopes] || []).each do |scope|
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