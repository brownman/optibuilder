namespace :svn do
  desc "Svn plus manipulation. Require subversion"
  task :up => :environment do
    op = %x[svn up '{ print $1 }' | xargs]
    puts op
  end

  desc "teste"
  task :diff do
    cmd = "svn diff #{RAILS_ROOT}"
    
    op = %x[#{cmd} | xargs]
    puts op.to_s
  end

  task :status do
    cmd = "svn st #{RAILS_ROOT}"
    
    op = %x[#{cmd} | xargs]
    puts op.to_s
  end


end
