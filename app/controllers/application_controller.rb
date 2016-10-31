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

  attr_reader :current_tab, :current_user

  def require_user!
    if ! tid = sandstorm_header(:tab_id)
      raise 'This app needs to run inside of sandstorm'
    end
    if ! uid = sandstorm_header(:user_id)
      raise 'You must be logged in to use this app'
    end
    @current_user = User.find_or_initialize_by(uid: uid)
    @current_tab = @current_user.tabs.where(tid: tid).first_or_initialize
    @current_user.update!(
      name: sandstorm_header(:username),
      picture: sandstorm_header(:user_picture),
      pronouns: sandstorm_header(:user_pronouns))
  end

  private

  def sandstorm_header(field)
    raw_header = request.env["HTTP_X_SANDSTORM_#{field.to_s.upcase}"]
    if field == :username
      URI.unescape(raw_header).force_encoding(Encoding::UTF_8)
    else
      raw_header&.encode(Encoding::UTF_8)
    end
  end
end
