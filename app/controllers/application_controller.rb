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
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_user!

  def require_user!
    if ! sandstorm_header(:tab_id)
      raise 'This app needs to run inside of sandstorm'
    end
    if ! uid = sandstorm_header(:user_id)
      raise 'You must be logged in to use this app'
    end
    user = User.find_or_initialize_by(uid: uid)
    user.name = sandstorm_header(:username)
    user.picture = sandstorm_header(:user_picture)
    user.pronouns = sandstorm_header(:user_pronouns)
    user.save!
    self.current_user = user
  end

  def current_user
    @current_user
  end

  private

  def current_user=(user)
    @current_user ||= user
  end

  def sandstorm_header(field)
    raw_header = request.env["HTTP_X_SANDSTORM_#{field.to_s.upcase}"]
    if field == :username
      URI.unescape(raw_header).force_encoding(Encoding::UTF_8)
    else
      raw_header&.encode(Encoding::UTF_8)
    end
  end
end
