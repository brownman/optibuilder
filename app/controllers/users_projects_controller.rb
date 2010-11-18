class UsersProjectsController < ApplicationController
  # GET /users/store/id
  # JSON
   def store
      if params[:id]
        list = []
        users_projects =
        UsersProject.all(:conditions => ['project_id = ?', params[:id]])

        users_projects.each do |u|
          list << {
            :id => u.id,
            :user_name => u.user.name,
            :user_id => u.user.id,
            :role_id => u.role,
            :role_name => u.role_name,
            :company_description => u.user.company_description,
            :contact_phone => u.user.contact_phone,
            :comments => u.user.comments
          }
        end

        total = users_projects.size
        render(:json => {:success => true, :root => list, :totalCount => total})
      end
   end
end
