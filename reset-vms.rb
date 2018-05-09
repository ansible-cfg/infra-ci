#!/usr/bin/env ruby
require 'net/http'
require 'uri'
require 'open3'
require 'optparse'
require "resolv"

DOMAIN=".dev-comutitres.fr"
ENVS=["dev", "vm"]

#####################################################################
#
# CLI ARGS
#
#####################################################################
options = {
    :verbose => false,
    :no_wait => false
}

OptionParser.new do |opts|
  opts.banner = "Usage: reset-vms.rb [options]"

  opts.on("-v", "--verbose", "Run verbosely") do |v|
    options[:verbose] = true
  end
  opts.on("-h", "--help", "Show this message") do
    puts opts
    exit
  end

end.parse!

puts options

environment = "dev"
loop do
  printf "Which environment to reset 'dev/vm' ? "
  input = gets.chomp
  environment = input if ENVS.include? input
  break if ENVS.include? input
end
printf "environment: #{environment}\n"

vms = []
loop do
  printf "Which vms to reset '1,2,3...' ? "
  input = gets.chomp
  vms = input.split(%r{,\s*}).map { |elem| elem.to_i }
  break unless vms.empty?
end

printf "vms: #{vms}\n"
hosts = vms.map { |elem| "#{environment}#{elem}#{DOMAIN}" }
printf "About to reset #{hosts}\n"

hosts.each do |host|
  address = Resolv.getaddress(host)
  puts address

  cmd = "ssh-keygen -R #{host}"
  logs, status = Open3.capture2e(cmd)
  printf "#{host}: ssh-keygen OK\n" if status.success?
  printf "#{host}: ssh-keygen KO\n" unless status.success?

  cmd = "ssh-keygen -R #{address}"
  logs, status = Open3.capture2e(cmd)
  printf "#{host}: ssh-keygen OK\n" if status.success?
  printf "#{host}: ssh-keygen KO\n" unless status.success?

  cmd = "ssh-keyscan -H #{host} >> ~/.ssh/known_hosts"
  logs, status = Open3.capture2e(cmd)
  printf "#{host}: ssh-keyscan OK\n" if status.success?
  printf "#{host}: ssh-keyscan KO\n" unless status.success?
end

env_inventory = if environment == "dev"
                  "inventory/ovh-dev"
                else
                  "inventory/ovh-ci"
                end
password_file = if environment == "dev"
                  "~/.comutitres/password-dev"
                else
                  "~/.comutitres/password-ci"
                end

root_env_password = File.open(File.expand_path(password_file), "rb").read

cmd = "ansible-playbook -i #{env_inventory} playbooks/invalidate_root.yml --extra-vars \"root_new_password=#{root_env_password}\""
Open3.popen2e(cmd) do |stdin, stdout_stderr, wait_thread|
  Thread.new do
    stdout_stderr.each {|l| puts l }
  end

#  stdin.puts 'ls'
#  stdin.close

  wait_thread.value
end

cmd = "ansible-playbook -i #{env_inventory} playbooks/declare_users.yml  -u arnauld"
Open3.popen2e(cmd) do |stdin, stdout_stderr, wait_thread|
  Thread.new do
    stdout_stderr.each {|l| puts l }
  end

#  stdin.puts 'ls'
#  stdin.close

  wait_thread.value
end
