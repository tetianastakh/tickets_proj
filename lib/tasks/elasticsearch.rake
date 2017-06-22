require 'elasticsearch/rails/tasks/import'

namespace :elasticsearch do
  task :sync_elasticsearch do
    sh "rake environment elasticsearch:import:model CLASS='Ticket' FORCE=true"
  end
end
