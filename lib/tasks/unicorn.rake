namespace :unicorn do
  task(:start) do
    raise 'Unicorn is already running.' if File.exist?('tmp/unicorn.pid')
    config_path = Rails.root.join('config/unicorn.rb')
    environment = 'production'
    `bundle exec unicorn_rails -c #{config_path} -E #{environment} -D`
  end

  task(:stop) do
    signal_to_unicorn(:QUIT)
  end

  task(:restart) do
    signal_to_unicorn(:USR2)
  end
end

def signal_to_unicorn(signal)
  Process.kill(signal, unicorn_pid)
end

def unicorn_pid
  File.read(Rails.root.join('tmp/unicorn.pid')).to_i
rescue Errno::ENOENT
  raise 'Unicorn is not running.'
end
