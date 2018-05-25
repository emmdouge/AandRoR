require 'fileutils'

# Hardlinks work only for files
# FileUtils.ln('./dir/file', './link')

# Run in cmd as admin
# ruby ang_symlink.rb
# Softlinks to directories are created as symlink
# allows localhost base route to work
FileUtils.ln_s('./app/client/dist/prod', './public')