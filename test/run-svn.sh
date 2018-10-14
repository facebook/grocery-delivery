#!/usr/bin/env bash

set -e
set -o verbose
bundle exec chef-zero &
ZERO=$!
trap "kill -9 $ZERO" EXIT
SOURCE=/tmp/source
sleep 5

rm -rf /tmp/master_path
rm -rf $SOURCE
rm -rf $SOURCE-import
rm -rf $SOURCE-checkout

function gd {
  bundle exec ./bin/grocery-delivery -c test/gd-svn.rb -vv
}

(
  mkdir $SOURCE
  svnadmin create $SOURCE
  mkdir $SOURCE-import && cd $SOURCE-import && touch test && svn import . file://$SOURCE -m"Dummy commit"
)
gd
(
  svn checkout file://$SOURCE $SOURCE-checkout
  cd $SOURCE-checkout
  mkdir chef/cookbooks/cookbook1/recipes -p
  touch chef/cookbooks/cookbook1/recipes/default.rb
  echo "name 'cookbook1'" > chef/cookbooks/cookbook1/metadata.rb
  svn add chef
  svn commit chef -m"Add cookbook1"
)
gd
(
  cd $SOURCE-checkout
  touch chef/cookbooks/cookbook1/recipes/recipe2.rb
  svn add chef/cookbooks/cookbook1/recipes/recipe2.rb
  svn commit chef -m"Modify cookbook1"
)
gd
(
  cd $SOURCE-checkout
  svn delete chef/cookbooks/cookbook1/metadata.rb
  svn delete chef/cookbooks/cookbook1/recipes/default.rb
  svn delete chef/cookbooks/cookbook1/recipes/recipe2.rb
  svn status
  svn commit -m"Remove cookbook1"
)
gd

