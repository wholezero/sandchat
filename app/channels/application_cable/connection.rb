#
# SandChat - Sandstorm chat server
#
# Copyright 2016 Steven Dee i@wholezero.org
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
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
