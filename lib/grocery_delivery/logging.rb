# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2

# Copyright 2013-present Facebook
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'syslog'
require 'logger'

module GroceryDelivery
  # Logging wrapper
  # rubocop:disable ClassVars
  module Log
    @@init = false
    @@level = Logger::WARN

    def self.init
      Syslog.open(File.basename($PROGRAM_NAME, '.rb'))
      @@init = true
    end

    def self.level
      @@level
    end

    def self.verbosity=(val)
      @@level = val
    end

    def self.stdout=(val)
      @@stdout = val
    end

    def self.logit(level, msg)
      init unless @@init
      # You can't do `Syslog.log(level, msg)` because if there is a
      # `%` in `msg` then ruby will interpret it as a printf string and
      # expect more arguments to log().
      Syslog.log(level, '%s', msg)
      puts msg if $stdout.tty? || @@stdout
    end

    def self.debug(msg)
      if @@level == Logger::DEBUG
        msg.to_s.prepend('DEBUG: ')
        logit(Syslog::LOG_DEBUG, msg)
      end
    end

    def self.info(msg)
      if @@level == Logger::INFO
        msg.to_s.prepend('INFO: ')
        logit(Syslog::LOG_INFO, msg)
      end
    end

    def self.warn(msg)
      msg.to_s.prepend('WARN: ')
      logit(Syslog::LOG_WARNING, msg)
    end

    def self.error(msg)
      msg.to_s.prepend('ERROR: ')
      logit(Syslog::LOG_ERR, msg)
    end
  end
  # rubocop:enable ClassVars
end
