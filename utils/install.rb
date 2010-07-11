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
AT_TOOLS_BIN = AT_TOOLS_DIR + '/bin'

puts "Making directories"
FileUtils.mkdir(AT_TOOLS_BIN)

puts "Linking update scripts"
FileUtils.ln_s(AT_TOOLS_DIR + '/utils/update.rb',
               AT_TOOLS_BIN + '/at-tools-update')

puts "Linking programs"
FileUtils.ln_s(AT_TOOLS_DIR + '/cascader/bin/cascader',
               AT_TOOLS_BIN + '/cascader')

FileUtils.ln_s(AT_TOOLS_DIR + '/cascader-gui/bin/cascader-gui',
	       AT_TOOLS_BIN + '/cascader-gui')

FileUtils.ln_s(AT_TOOLS_DIR + '/print/bin/print',
               AT_TOOLS_BIN + '/print')

FileUtils.ln_s(AT_TOOLS_DIR + '/cen/cen.rb',
               AT_TOOLS_BIN + '/cen')

puts "Updating at-tools"
command('./update.rb', AT_TOOLS_DIR + '/utils')

puts "Updating PATH"
command('echo "PATH=$PATH:' + AT_TOOLS_BIN + '" >> ~/.bash_profile')
command('source ~/.bash_profile')
