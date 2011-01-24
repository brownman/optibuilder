class Fiber < ActiveRecord::Base
  belongs_to :cable
  belongs_to :subrack_a, :class_name => "Subrack", :foreign_key => "subrack_a_id", :validate => true
  belongs_to :subrack_b, :class_name => "Subrack", :foreign_key => "subrack_b_id", :validate => true
  has_many :test_attenuation
  has_many :test_chromatic_disp
  has_many :test_orl
  has_many :test_pmd
end
