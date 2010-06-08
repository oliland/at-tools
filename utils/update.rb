#!/usr/bin/env ruby

# Updater for at-tools (www.github.com/xoebus/at-tools)

def command(command, dir = '.')
    Dir.chdir(dir) do
        return `#{command}`.chomp
    end
end

AT_TOOLS_SRC = File.expand_path('~/.at-tools/at-tools')

puts 'Checking for changes and updating at-tools core and programs...'
command('git pull', AT_TOOLS_SRC)
