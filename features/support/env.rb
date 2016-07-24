require 'yapaas'
require 'docker'
require 'docker/machine'

$:.push("lib") unless $:.include?("lib")
ENV['PATH'] = "#{ENV['PATH']}:./exe"
