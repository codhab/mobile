# This file is used by Rack-based servers to start the application.
# Unicorn self-process killer
if Rails.env.production?
  require 'unicorn/worker_killer'
# Max requests per worker
  use Unicorn::WorkerKiller::MaxRequests, 3072, 4096

  # Max memory size (RSS) per worker
  use Unicorn::WorkerKiller::Oom, (192*(1024**2)), (256*(1024**2))
end

require_relative 'config/environment'

run Rails.application
