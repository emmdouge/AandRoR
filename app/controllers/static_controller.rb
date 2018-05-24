require 'find'
class StaticController < ApplicationController

  include ActionDispatch

  def index
    # file_paths = Find.find(Rails.root).select { |p| /.*ngsw.json$/ =~ p }
    # puts "\n\n\n"+file_paths.to_yaml+"\n\n\n"
    path = Rails.root.join('app').to_s
    puts path
    puts Dir.entries(path).select {|entry| File.directory? File.join(path,entry) and !(entry =='.' || entry == '..') }
    render file: "/app/client/dist/prod/index.html"
  end
end
