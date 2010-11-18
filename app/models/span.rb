class Span < ActiveRecord::Base
  belongs_to :project
  belongs_to :company
  belongs_to :site_a, :class_name => 'Site', :foreign_key => 'site_a_id', :validate => true
  belongs_to :site_b, :class_name => 'Site', :foreign_key => 'site_b_id', :validate => true
  has_many :fibers
  has_many :cables
end
