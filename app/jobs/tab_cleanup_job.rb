class TabCleanupJob < ApplicationJob
  queue_as :default

  def perform
    destroyed = Tab.where('updated_at < ?', 10.minutes.ago).destroy_all
    Rails.logger.info "Cleaned up tabs: #{destroyed}" unless destroyed.empty?
  end

  after_perform do |job|
    self.class.new.enqueue(wait: 5.minutes)
  end
end
