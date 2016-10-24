class Chat < ApplicationRecord
  belongs_to :user
  validates :message, presence: true, length: {minimum: 2, maximum: 1000}

  def timestamp
    created_at.strftime('%H:%M:%S %d %B %Y')
  end

  after_create_commit do
    puts "after create"
    ChatBroadcastJob.perform_later(self)
  end
end
