# config/puma.rb
require 'rails'  # この行を追加

# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

# Specifies the `worker_timeout` threshold that Puma will use to wait before
# terminating a worker in development environments.
#
worker_timeout 3600 if ENV.fetch("RAILS_ENV", "development") == "development"

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
#
port ENV.fetch("PORT") { 3000 }

# Specifies the `environment` that Puma will run in.
#
environment ENV.fetch("RAILS_ENV") { "development" }

# Specifies the `pidfile` that Puma will use.
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart

# ソケットパスの設定
bind "unix://#{Dir.pwd}/tmp/sockets/puma.sock"

# 本番環境のみデーモン起動
if ENV['RAILS_ENV'] == 'production'
  pidfile "#{Dir.pwd}/tmp/pids/puma.pid"
  state_path "#{Dir.pwd}/tmp/pids/puma.state"
  stdout_redirect(
    "#{Dir.pwd}/log/puma.log",
    "#{Dir.pwd}/log/puma-error.log",
    true
  )
  # デーモン
  daemonize
end
