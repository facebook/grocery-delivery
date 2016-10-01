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

module GroceryDelivery
  # Hook class for GD
  class Hooks
    # This code will run once we've read our config and loaded our plugins
    # but before *anything* else. We don't even have a lock yet.
    def self.preflight_checks(_dryrun)
    end

    # This is run after we've gotten a lock, written a pidfile and initialized
    # our repo object (but not touched the repo yet)
    def self.prerun(_dryrun)
    end

    # This is code to run after we've updated the repo, but before we've done
    # any work to parse it.
    def self.post_repo_up(_dryrun)
    end

    # After we parse the updates to the repo and uploaded/deleted the relevent
    # items from the local server.
    def self.postrun(_dryrun, _success, _msg)
    end

    # exit hooks.
    def self.atexit(_dryrun, _success, _msg)
    end

    def self.get(file)
      class_eval(File.read(file), file, 1) if File.exists?(file)
    end
  end
end
