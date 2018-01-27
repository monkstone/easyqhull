require_relative 'lib/easyqhull/version'

def create_manifest
  title = 'Implementation-Title: EasyQHull for JRubyArt and propane)'
  version = format('Implementation-Version: %s', EasyQHull::VERSION)
  File.open('MANIFEST.MF', 'w') do |f|
    f.puts(title)
    f.puts(version)
  end
end

task default: [:init, :compile, :install, :gem]

desc 'Create Manifest'
task :init do
  create_manifest
end

desc 'Install'
task :install do
  sh 'mv target/easyqhull.jar lib'
end

desc 'Gem'
task :gem do
  sh 'gem build easyqhull.gemspec'
end

desc 'Compile'
task :compile do
  sh 'mvn package'
end
