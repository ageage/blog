namespace :unicorn do
  task :stop do
    unicorn_pid_file_path = Rails.root.join('tmp/unicorn.pid')
    if File.exists?(unicorn_pid_file_path)
      unicorn_pid = `cat #{Rails.root.join('tmp/unicorn.pid')}`.chomp
      `kill -QUIT #{unicorn_pid}`
      puts "Killed Unicorn.(pid:#{unicorn_pid})" if $?.success?
    else
      puts 'Unicorn is not running.'
    end
  end
end
