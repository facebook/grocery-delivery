#!/usr/bin/env bash

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

set -e
set -o verbose
bundle exec chef-zero &
ZERO=$!
trap "kill -9 $ZERO" EXIT
SOURCE=/tmp/source
sleep 5

rm -rf /tmp/master_path
rm -rf $SOURCE
GIT="git -c user.email='foo@bar.com' -c user.name='foobar'"

function gd {
  bundle exec ./bin/grocery-delivery -c test/gd-git.rb -vv
}

(
  mkdir $SOURCE
  $GIT init $SOURCE
  cd $SOURCE && touch test && $GIT add . -A && $GIT commit -m "Dummy commit"
)
gd
(
  cd $SOURCE
  mkdir chef/cookbooks/cookbook1/recipes -p
  touch chef/cookbooks/cookbook1/recipes/default.rb
  echo "name 'cookbook1'" > chef/cookbooks/cookbook1/metadata.rb
  $GIT add . -A
  $GIT commit -m "Add cookbook1"
)
gd
(
  cd $SOURCE
  touch chef/cookbooks/cookbook1/recipes/recipe2.rb
  $GIT add . -A
  $GIT commit -m "Modify cookbook1"
)
gd
(
  cd $SOURCE
  rm -rf chef/cookbooks/cookbook1
  $GIT add . -A
  $GIT commit -m "Remove cookbook1"
)
gd

