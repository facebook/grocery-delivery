#!/usr/bin/env bash

set -e
set -o verbose
bundle exec chef-zero &
ZERO=$!
SOURCE=/tmp/source
sleep 5

rm -rf /tmp/master_path
rm -rf $SOURCE
GIT="git -c user.email='foo@bar.com' -c user.name='foobar'"

function gd {
  bundle exec ./bin/grocery-delivery -c test/gd.rb -vv
}

(
  mkdir $SOURCE
  $GIT init $SOURCE
  cd $SOURCE && touch test && $GIT add . -A && $GIT commit -m "commit1"
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

kill -9 $ZERO
