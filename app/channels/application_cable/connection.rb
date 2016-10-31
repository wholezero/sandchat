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
    identified_by :current_tab

    def connect
      self.current_tab = find_tab
      logger.add_tags current_tab.tid, current_tab.user.uid
    end

    protected

    def find_tab
      if tab = Tab.find_by(
          tid: request.env['HTTP_X_SANDSTORM_TAB_ID'])
        tab
      else
        reject_unauthorized_connection
      end
    end
  end
end
