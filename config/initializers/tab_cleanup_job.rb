Rails.application.config.after_initialize do
  Tab.destroy_all if ActiveRecord::Base.connection.table_exists? 'tabs'
  TabCleanupJob.new.enqueue(wait: 10.minutes)
end
