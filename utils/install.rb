#!/usr/bin/env ruby

# Installer for at-tools (www.github.com/xoebus/at-tools)

require 'fileutils'
require 'pathname'

def command(command, dir = '.')
    Dir.chdir(dir) do
        return `#{command}`.chomp
    end
end

AT_TOOLS_DIR = File.expand_path('~/.at-tools/')

puts "Making directories"
FileUtils.mkdir(AT_TOOLS_DIR + '/bin')

puts "Linking update scripts"
FileUtils.ln_s(AT_TOOLS_DIR + '/utils/update.rb',
               AT_TOOLS_DIR + '/bin/at-tools-update')

puts "Updating at-tools"
command('./update.rb', AT_TOOLS_DIR + '/utils')

puts "Updating PATH"
command('echo "PATH=$PATH:"' + AT_TOOLS_DIR + '/bin' + ' >> ~/.bash_profile')
command('source .bash_profile', File.expand_path('~'))
