class SubrackName < ActiveRecord::Base
  belongs_to :site
  belongs_to :diagram
  has_many :fibers

   def network_type_name
    return read_attribute(:network_type) if read_attribute(:network_type).nil? or not read_attribute(:network_type).to_i
    att =  '-'
      case read_attribute(:network_type).to_i
        when 1
          att = 'Subterran'
        when 2
          att = 'Aerial'
        when 3
          att = 'Submarine'
        when 4
          att = 'Other'
       end
     end
end
