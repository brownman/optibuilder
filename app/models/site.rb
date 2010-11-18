class Site < ActiveRecord::Base
  belongs_to :address, :dependent => :destroy
  belongs_to :owner, :class_name => 'Company', :foreign_key => 'network_owner_id', :validate => true
  has_many :subrack_name
end
