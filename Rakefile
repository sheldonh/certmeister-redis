require "rspec/core/rake_task"
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')
require "certmeister/redis/version"

desc 'Build gem into the pkg directory'
task :build => :spec do
  FileUtils.rm_rf('pkg')
  Dir['*.gemspec'].each do |gemspec|
    system "gem build #{gemspec}"
  end
  FileUtils.mkdir_p('pkg')
  FileUtils.mv(Dir['*.gem'], 'pkg')
end

desc 'Tags version, pushes to remote, and pushes gem'
task :release => :build do
  sh 'git', 'tag', '-m', "Released v#{Certmeister::Redis::VERSION}", "v#{Certmeister::Redis::VERSION}"
  sh "git push origin master"
  sh "git push origin v#{Certmeister::Redis::VERSION}"
  sh "ls pkg/*.gem | xargs -n 1 gem push"
end

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
