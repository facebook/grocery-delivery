# Grocery Delivery

![Continuous Integration](https://github.com/facebook/grocery-delivery/workflows/Continuous%20Integration/badge.svg?event=push)

## Intro
Ohai!

Welcome to Grocery Delivery, software to keep cookbooks, roles, and databags in
sync between a VCS repo and a chef server. The idea is that if you have
multiple, distinct Chef server instances that should all be identical, they can
all run this script in cron. The script uses proper locking, so you should be
able to run it every minute.

However, there are several things to know:
* It assumes you don't leverage versions or environments.
* It assumes you want anything committed to HEAD to be uploaded immediately.

Grocery Delivery is pretty customizable. Many things can be tuned from a simple
config file, and it's pluggable so you can extend it as well.

## Prerequisites

Grocery Delivery is a particular way of managing your Chef infrastructure,
and it assumes you follow that model consistently. Here are the basic
principals:

* Checkins are live immediately (which implies code review before merge)
* Versions are meaningless (ideally, never change them)
* You want all your chef-servers in sync
* Everything you care about comes from version control.

We recommend enabling attributes whitelisting to prevent node attributes being
saved back to the server. In recent versions of Chef (past Chef 11), this
feature is [built-in](https://docs.chef.io/nodes/#whitelist-attributes). For
older versions, we recommend using the
[`whitelist_node_attrs`](https://github.com/chef-boneyard/whitelist-node-attrs)
cookbook.

## Dependencies

* Mixlib::Config
* BetweenMeals

## Config file

The default config file is `/etc/gd-config.rb` but you may use `-c` to specify
another. The config file works the same as client.rb does for Chef - there
are a series of keywords that take an argument and anything else is just
standard Ruby.

The following configuration options are available:
* **`berks`**

	Description: Determines if we should use Berkshelf to resolve dependencies and upload cookbooks
	
	CLI Argument(s): `'-b'`, `'--berks'`

	Value data type: `Boolean`

	Default: `false`

	Notes: Existence of CLI argument equates to `true`


* **`berks_bin`** 

	Description: Path to Berkshelf binary.
	
	CLI Argument(s): `'-B', '--berks-bin FILE'`

	Value data type: `String`

	Default: `/opt/chefdk/bin/berks`


* **`berks_config`**

	Description: Path to Berkshelf config.
	
	CLI Argument(s): `'--berks-config FILE'`

	Value data type: `String` 

	Default: `nil`


* **`config_file`**

	Description: Path to Grocery Delivery config
	
	CLI Argument(s): `-c`, `--config-file FILE`

	Value data type: `String`

	Default: `/etc/gd-config.rb`


* **`cookbook_paths`** 

	Description: An (space-delimited) array of directories that contain cookbooks relative to `reponame`
	
	CLI Argument(s): `'--cookbook-paths DIRECTORY1 DIRECTORY2 DIRECTORY3 ...'`

	Value data type: `String`

	Default: `['chef/cookbooks']`


* **`databag_path`**

	Description: A directory to find databags in relative to `reponame`.
	
	CLI Argument(s): `'-d', '--databag-path FILE'`

	Value data type: `String`

	Default: `'chef/databags'`


* **`dry_run`**

	Description: Enable dry-run mode.
	
	CLI Argument(s): `'-n', '--dry-run'`

	Value data type: `Boolean`

	Default: `false`

	Notes: Existence of CLI argument equates to `true`


* **`knife_bin`**

	Description: Path to `knife` binary.
	
	CLI Argument(s): `'-k', '--knife-bin FILE'`

	Value data type: `String`

	Default: `/opt/chef/bin/knife`

	Notes: e.g. `/var/chef/grocery_delivery_work/ops/chef/cookbooks`


* **`knife_config`**

	Description: Knife config to use for uploads.
	
	CLI Argument(s): `'-K', '--knife-config FILE'`

	Value data type: `String`

	Default: `/root/.chef/knife.rb`

	Notes: `knife.rb` will need to set `cookbook_path` pointing to the cookbook path in the work directory


* **`lockfile`**

	Description: Path to lockfile.
	
	CLI Argument(s): `'-l', '--lockfile FILE'`

	Value data type: `String`

	Default: `/var/lock/subsys/grocery_delivery`


* **`master_path`**

	Description: The top-level path for Grocery Delivery's work (most other paths are relative to this).
	
	CLI Argument(s): `'-m', '--master-path FILE'`

	Value data type: `String`

	Default: `/var/chef/grocery_delivery_work`


* **`pidfile`**

	Description: Path to pidfile.

	CLI Argument(s): `-p, --pidfile FILE`

	Value data type: `String`

	Default: `/var/run/grocery_delivery.pid`


* **`plugin_path`**

	Description: Path to plugin file.
	
	CLI Argument(s): `'-P', '--plugin-path FILE'`

	Value data type: `String`

	Default: `/etc/gd-plugin.rb`

* **`repo_update`**

	Description: Enable/disable cookbook repo update before run.
	
	CLI Argument(s): `'-U', '--no-repo-update BOOL'`

	Value data type: `Boolean`

	Default: `true`

	Note: Existence of CLI argument equates to `false`

* **`repo_url`**

	Description: The URL to clone/checkout if it doesn't exist.
	
	CLI Argument(s): `'-u', '--repo-url URL'`

	Value data type: `String`

	Default: `nil`


* **`reponame`**

	Description: The relative directory to check the repo out to, inside of `master_path`.
	
	CLI Argument(s): `'-N', '--repo-name'`

	Value data type: `String`

	Default: `ops`


* **`rev_checkpoint`**

	Description: Name of the file to store the last-uploaded revision, relative to `reponame`.
	
	CLI Argument(s): `'-C', '--revision-checkpoint FILE'`

	Value data type: `String`

	Default: `gd_revision`


* **`role_path`**

	Description: A directory to find roles in relative to `reponame`.
	
	CLI Argument(s): `'-r', '--role-path FILE'`

	Value data type: `String`

	Default: `'chef/roles'`


* **`role_type`**

	Description: RB or JSON roles?
	
	CLI Argument(s): `'-R', '--role-type TYPE'`

	Value data type: `String`

	Default: `rb`

* **`stdout`**

	Description: Log to stdout as well.
	
	CLI Argument(s): `'--stdout'`

	Value data type: `Boolean` 

	Default: `false`

	Notes: Existence of CLI argument equates to `true`


* **`track_symlinks`**

	Description: Whether or not to track symlinks.
	
	CLI Argument(s): `'--track-symlinks'`

	Value data type: `Boolean` 

	Default: `false`

	Notes: Existence of CLI argument equates to `true`


* **`vcs_path`**

	Description: Path to git or svn binary.
	
	CLI Argument(s): `'--vcs-path FILE'`

	Value data type: `String`

	Default: `nil`

	Notes: If not given, just uses 'git' or 'svn'

* **`vcs_type`**

	Description: Git or SVN?

	CLI Argument(s): `'--vcs-type TYPE'`

	Value data type: `String`

	Default: `svn`

	Notes: 

* **`verbosity`**

	Description: Verbosity level.
	
	CLI Argument(s): `'-v'`, `'--verbosity'`

	Value data type: N/A

	Default: `WARN`

	Notes: Specify twice via CLI for debug.


The following CLI arguments are also available:
* no_update (bool, default: `false`)

## Plugin

The plugin should be a ruby file which defines several class methods. It is
`class_eval()`d into a `Hooks` class.

The following functions can optionally be defined:

* self.preflight_checks(dryrun)

This code will run once we've read our config and loaded our plugins but before
*anything* else. We don't even have a lock yet. `Dryrun` is a bool which
indicates if we are in dryrun mode.

* self.prerun(dryrun)

This is run after we've gotten a lock, written a pidfile and initialized our
repo object (but not touched the repo yet)

* self.post_repo_up(dryrun)

This is code to run after we've updated the repo, but before we've done any work
to parse it.

* self.postrun(dryrun, success, msg)

After we've parsed the updates to the repo and uploaded/deleted the relevant
items from the local server. `Success` is a bool for whether we succeeded, and
`msg` is the status message - either the revision we sync'd or an error.

* self.atexit(dryrun, success, msg)

Same as postrun, but is registered as an atexit function so it happens even
if we crash.

## License

See the `LICENSE` file in this repo.
