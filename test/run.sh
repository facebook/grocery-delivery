#!/usr/bin/env bash
set -o verbose
set -e
rm -rf /tmp/gd &> /dev/null
export HOME='/tmp/gd'
export REPO='/tmp/gd/repo1'
mkdir -p $REPO
git config --global user.email "foo@bar.com"
git config --global user.name "Foo Bar"
(mkdir $REPO/recipes && mkdir $REPO/roles && echo 'name "foo"' > $REPO/roles/foo.rb && echo 'name "foo"' > $REPO/metadata.rb && git init $REPO/ && cd $REPO && git add * && git commit -m'foo') &>/dev/null
bundle exec chef-zero &
ZERO=$!
sleep 5
bundle exec grocery-delivery -n -c ./test/gd.rb
EXIT=$?
kill $ZERO
exit $EXIT
