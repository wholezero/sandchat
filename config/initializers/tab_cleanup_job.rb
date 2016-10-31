Tab.destroy_all if ActiveRecord::Base.connection.table_exists? 'tabs'
# TODO(someday): why does this raise if we just call perform_later?
TabCleanupJob.new.enqueue(wait: 5.minutes)
