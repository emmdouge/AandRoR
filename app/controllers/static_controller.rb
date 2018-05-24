require 'find'
class StaticController < ApplicationController

  include ActionDispatch

  def index
    # file_paths = Find.find(Rails.root).select { |p| /.*ngsw.json$/ =~ p }
    # puts "\n\n\n"+file_paths.to_yaml+"\n\n\n"
    puts Rails.root
    puts Dir.entries(Rails.root.join('app').to_s).select {|entry| File.directory? File.join(Rails.root,entry) and !(entry =='.' || entry == '..') }
    render file: "/app/client/dist/prod/index.html"
  end
end
