class Address < ActiveRecord::Base
  has_many :companies, :dependent  => :nullify
  has_many :sites, :dependent  => :nullify
  
  #############################################################
  # @author: RonaldoPossan
  # @date: 2010/11/01
  # Method to verify if a Instantiated address is fully filled
  # or unfilled
  # #return: Boolean
  #############################################################
  def unfilled?
    false
    if  (self.country.nil? or self.state.blank?) and
        (self.state.nil? or self.state.blank?) and
        (self.city.nil? or self.city.blank?) and
        (self.street.nil? or self.street.blank?) and
        (self.location.nil? or self.location.blank?) and
        (self.zip_code.nil? or self.zip_code.blank?) and
        (self.complement.nil? or self.complement.blank?)
        true
    end
  end

end
