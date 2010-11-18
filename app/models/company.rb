class Company < ActiveRecord::Base
  belongs_to :address, :dependent => :destroy
  has_many :projects
  has_many :users
  has_many :sites
  has_many :spans
end
