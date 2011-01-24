class UsersProject < ActiveRecord::Base
  has_and_belongs_to_many :projects
  belongs_to :user

  #############################################################
  # @author: RonaldoPossan
  # @date: 2010/11/09
  #Virtual attribute method to show human name.
  #############################################################
  def role_name
    return read_attribute(:role) if read_attribute(:role).nil? or not read_attribute(:role).to_i
    att =  '-'
    case read_attribute(:role).to_i
      when 0
        att = 'Admin'
      when 1
        att = 'User'
      when 2
        att = 'Consultant'
      when 3
        att = 'Contact'
    end
  end

end
