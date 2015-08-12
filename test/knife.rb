log_level :info
log_location STDOUT
node_name 'gd'
client_key 'gd.pem'
validation_client_name 'chef-validator'
validation_key 'chef-validator.pem'
chef_server_url 'http://127.0.0.1:8889'
cookbook_path [
  '/tmp/master_path/target/chef/cookbooks/',
]
