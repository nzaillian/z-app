module ActiveRecord
  class Base
    def self.utc_accessor(*attr_names)      
      attr_names.each do |attr_name|

        attr_name = attr_name.to_s

        accessor_body = <<-EOS          

          def #{attr_name}=(val)
            if val.class == String
              val = DateTime.parse(val)
            end

            if [DateTime, Time, ::ActiveSupport::TimeWithZone, Date].include?(val.class)
              val = val.to_datetime if val.class != DateTime      
              shifted = val.shift_time_zone('UTC')
              write_attribute(:#{attr_name}, shifted)
            else
              write_attribute(:#{attr_name}, val)
            end
          end

          def #{attr_name}
            read_attribute(:#{attr_name})
          end

        EOS

        class_eval(accessor_body)          
      end
    end
  end
end