require 'fileutils'

# Hardlinks work only for files
# FileUtils.ln('./dir/file', './link')

# Run in cmd as admin
# ruby ang_symlink.rb
# Softlinks to directories are created as symlinkd
FileUtils.ln_s('./client/dist/prod', './public')