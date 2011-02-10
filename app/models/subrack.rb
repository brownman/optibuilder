class Subrack < ActiveRecord::Base
  belongs_to :site
  belongs_to :diagram
  has_many :fibers
end
