class Tab < ApplicationRecord
  belongs_to :user, touch: true, counter_cache: true
end
