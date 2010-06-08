if [ -d ~/.at-tools ]
then
  echo "You already have Appleton Tower Tools installed. You'll need to remove ~/.at-tools if you want to install"
  exit
fi

echo "Cloning Appleton Tower Tools..."
/usr/bin/env git clone git://github.com/xoebus/at-tools.git ~/.at-tools

echo "Installing on your system..."
/usr/bin/env ruby ~/.at-tools/utils/install.rb

echo '       _          _              _     '
echo '      | |        | |            | |    '
echo '  __ _| |_ ______| |_ ___   ___ | |___ '
echo ' / _` | __|______| __/ _ \ / _ \| / __|'
echo '| (_| | |_       | || (_) | (_) | \__ \'
echo ' \__,_|\__|       \__\___/ \___/|_|___/'
echo "....is now installed."

