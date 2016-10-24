module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags current_user.uid
    end

    protected

    def find_verified_user
      if verified_user = User.find_by(
          uid: request.env['HTTP_X_SANDSTORM_USER_ID'])
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
