class Cable < ActiveRecord::Base
  has_many :fibers
  belongs_to :span
end
