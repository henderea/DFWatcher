#!/usr/bin/env ruby

require 'rubygems'
require 'daemons'

#pwd = Dir.pwd
pwd = '/home/ubuntu/DFWatcher'
Daemons.run_proc('watcher.rb', { :dir_mode => :normal, :dir => '/opt/pids/etc' }) do
  Dir.chdir(pwd)
  exec 'ruby watcher.rb'
end
