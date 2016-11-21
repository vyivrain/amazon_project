# config valid only for current version of Capistrano
lock '3.5.0'

set :stages, %w(production staging)
set :application, 'amazon_project'
set :repo_url, 'https://github.com/vyivrain/amazon_project.git'
set :scm, :git
set :branch, :master
set :deploy_to, '/home/ec2-user/amazon_project'
set :pty, true
set :linked_files, %w{config/database.yml config/application.yml config/secrets.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}
set :keep_releases, 2
set :rvm_type, :user
set :rvm_ruby_version, '2.3.1'

set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_access.log"
set :puma_error_log, "#{shared_path}/log/puma_error.log"
set :puma_role, :app
set :puma_threads, [0, 8]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :puma_preload_app, false

stage = 'production'
desc 'check production task'
task :check_production do
  if stage.to_s == "production"
    puts " \n Are you REALLY sure you want to deploy to production?"
    puts " \n Enter the password to continue\n "
    password = STDIN.gets[0..7] rescue nil
    if password != 'mypasswd'
      puts "\n !!! WRONG PASSWORD !!!"
      exit
    end
  end
end

before 'deploy', 'check_production'