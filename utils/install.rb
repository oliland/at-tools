#!/usr/bin/env ruby

# Installer for at-tools (www.github.com/xoebus/at-tools)

require 'fileutils'
require 'pathname'

def command(command, dir = '.')
    Dir.chdir(dir) do
        return `#{command}`.chomp
    end
end

AT_TOOLS_DOWNLOAD = File.join(File.dirname(Pathname.new(__FILE__).realpath),'/..')
AT_TOOLS_DIR = File.expand_path('~/.at-tools/')
AT_TOOLS_SRC = File.expand_path('~/.at-tools/at-tools')

puts "Beginning installation"
puts "Making directories"
FileUtils.mkdir(AT_TOOLS_DIR)
FileUtils.mkdir(AT_TOOLS_DIR + '/bin')

puts "Copying files"
FileUtils.cp_r(AT_TOOLS_DOWNLOAD, AT_TOOLS_SRC)

puts "Linking files"
FileUtils.ln_s(AT_TOOLS_SRC + '/utils/update.rb',
               AT_TOOLS_DIR + '/bin/at-tools-update')

puts "Updating at-tools"
command('./update.rb', AT_TOOLS_DIR + '/at-tools/utils')

puts "Updating PATH"
command('echo "PATH=$PATH:"' + AT_TOOLS_DIR + '/bin' + ' >> ~/.bash_profile')
