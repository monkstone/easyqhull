require 'fileutils'
project 'easyqh', 'https://github.com/ruby-processing/JRubyArt' do

  model_version '4.0.0'
  id 'ruby-processing:easyqh', '0.3.0'
  packaging 'jar'

  description 'easyqh for processing'

  organization 'ruby-processing', 'https://ruby-processing.github.io'

  developer 'monkstone' do
    name 'Martin Prout'
    email 'mamba2928@yahoo.co.uk'
    roles 'developer'
  end

  issue_management 'https://github.com/ruby-processing/JRubyArt/issues', 'Github'

  source_control(
    url: 'https://github.com/ruby-processing/JRubyArt',
    connection: 'scm:git:git://github.com/ruby-processing/JRubyArt.git',
    developer_connection: 'scm:git:git@github.com/ruby-processing/JRubyArt.git'
  )

  properties(
    'maven.compiler.source' => '1.8',
    'project.build.sourceEncoding' => 'UTF-8',
    'maven.compiler.target' => '1.8',
    'polyglot.dump.pom' => 'pom.xml',
    'processing.api' => 'http://processing.github.io/processing-javadocs/core/',
  )

  jar 'org.processing:core:3.3.6'

  plugin_management do
    plugin :resources, '2.6'
    plugin :dependency, '2.8'
    plugin(
      :compiler, '3.7.0',
      source: '${maven.compiler.source}',
      target: '${maven.compiler.target}'
    )
    plugin(
      :javadoc, '2.10.4',
      detect_offline_links: 'false',
      links: ['${processing.api}', '${jruby.api}']
    )
  end
  build do
    default_goal 'package'
    source_directory 'src'
    final_name 'easyqhull'
  end
end
