# Updater for at-tools (www.github.com/lolsoft/at-tools)

def command(command, dir = '.')
    Dir.chdir(dir) do
        return `#{command}`.chomp
    end
end

AT_TOOLS_DIR = File.expand_path('~/.at-tools/')
AT_TOOLS_BIN = AT_TOOLS_DIR + '/bin'

# Should be installed.
LINKS = ['att', 'cascader', 'cascader-gui', 'cen', 'print']

class Updater
  def update
    puts 'Checking for changes and updating at-tools core and programs...'
    command('git pull', AT_TOOLS_DIR)
    create_new_links
  end
  
  def install app
    FileUtils.ln_s(AT_TOOLS_DIR + '/#{app}/bin/#{app}',
                   AT_TOOLS_BIN + '/#{app}')
  end
  
  def create_new_links
    Dir.chdir(AT_TOOLS_BIN) do
      currently_installed = Dir['*']
      need_to_install = LINKS - currently_installed
      need_to_install.each { |app| install(app) }
    end
  end
end
