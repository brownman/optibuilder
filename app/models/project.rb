class Project < ActiveRecord::Base

  serialize :users_projects

  belongs_to :owner, :class_name => 'Company', :foreign_key => 'network_owner_id', :validate => true
  belongs_to :customer, :class_name => 'Company', :foreign_key => 'customer_id', :validate => true

  has_many :users_projects, :class_name => "UsersProject", :dependent => :delete_all
  has_many :users_logs
  has_many :sites, :through => :spans
  has_many :spans

  #############################################################
  # @author: Ronaldo Possan
  # @date: 2010/11/09
  # Method to representation of relationship Projects x Sites,
  # where haven't direct relationship,
  # because the relation is between Projects x Spans.
  #############################################################
  def sites(options = {})
    ids = []
    self.spans.each do |s|
      ids << s.site_a_id
      ids << s.site_b_id
    end
    if ids.size > 0
      ids = ids.uniq.join(", ")
      conds = "id IN (#{ids})"
      conds = conds + " AND " + options[:conditions] if options[:conditions]
      Site.all(
                :select => options[:select],
                :conditions => conds,
                :order => options[:order],
                :limit => options[:limit],
                :offset => options[:offset]
      )
    else
      []
    end
  end

end
