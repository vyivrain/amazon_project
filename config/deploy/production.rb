set :user, 'ubuntu'
server 'ubuntu@ec2-35-164-181-183.us-west-2.compute.amazonaws.com', roles: [:app, :web, :db], primary: true
set :stage, 'production'
set :ssh_options, { keys: ['~/.ssh/amazon_rsa.pem'], forward_agent: true, user: 'ubuntu' }
