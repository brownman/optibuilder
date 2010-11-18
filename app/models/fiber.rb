class Fiber < ActiveRecord::Base
  belongs_to :subrack_name
  has_many :tests
  belongs_to :span
  belongs_to :cable
  has_one :fiber_end, :class_name => "Fiber", :foreign_key => "fiber_end_id", :validate => true
end
