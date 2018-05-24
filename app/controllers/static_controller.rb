require 'find'
class StaticController < ApplicationController

  include ActionDispatch

  def index
    path = Rails.root.join('app', 'client').to_s
    puts path
    puts Dir.entries(path).select {|entry| File.directory? File.join(path,entry) and !(entry =='.' || entry == '..') }
    
    # file_paths = Find.find(Rails.root).select { |p| /.*ngsw.json$/ =~ p }
    # puts "\n\n\n"+file_paths.to_yaml+"\n\n\n"

    render file: path+'/index.html'
  end
end
