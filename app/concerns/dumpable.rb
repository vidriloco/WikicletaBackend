module Dumpable
  module ClassMethods
    def dump_with(items, item, call_to_str=nil)
      sub_str = String.new
      items.each do |attr_|
        attr_value = item.send(attr_)
        
        attr_.gsub!('_to_s', '') if call_to_str
        
        if attr_value.nil?
          sub_str << %-:#{attr_.to_sym} => nil, -
        elsif attr_value.is_a?(String)
          if call_to_str
            sub_str << %-:#{attr_} => #{attr_value.to_s}, -
          else
            attr_escaped = attr_value.to_s.gsub(/["]/, '\"')
            sub_str << %-:#{attr_} => "#{attr_escaped}", -
          end
        elsif attr_value.is_a?(ActiveSupport::TimeWithZone) || attr_value.is_a?(Date) || attr_value.is_a?(DateTime)
          sub_str << %-:#{attr_} => "#{attr_value.to_s(:db)}", -
        else
          sub_str << %-:#{attr_} => #{attr_value}, -
        end
      end
      sub_str
    end

    def model_dump
      str = "#{self.to_s}.create(["
      self.to_s.constantize.all.each do |item|
        sub_str = String.new
        sub_str << self.dump_with(self.send(:attrs_for_dump), item)
        sub_str << self.dump_with(self.send(:attrs_for_dump_ex), item, true)
        str << "\n{#{sub_str.chop.chop}},"
      end
      "#{str.chop}]) \n\n"
    end
  end
  
  def self.included(base)
    base.extend(ClassMethods)
  end
end