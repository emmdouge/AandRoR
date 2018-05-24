require 'find'
class StaticController < ApplicationController

  include ActionDispatch

  def index
    path = Rails.root.join('app').to_s
    puts path
    puts Dir.entries(path).select {|entry| File.directory? File.join(path,entry) and !(entry =='.' || entry == '..') }
    puts "\n"
    puts Dir.entries(path+'/client').select {|entry| File.directory? File.join(path+'/client',entry) and !(entry =='.' || entry == '..') }
    puts "\n"
    puts Dir.entries(path+'/client/src').select {|entry| File.directory? File.join(path+'/client/dist',entry) and !(entry =='.' || entry == '..') }
    puts "\n"
    puts Dir.entries(path+'/client/src/client').select {|entry| File.directory? File.join(path+'/client/dist/prod',entry) and !(entry =='.' || entry == '..') }
    
    # file_paths = Find.find(Rails.root).select { |p| /.*ngsw.json$/ =~ p }
    # puts "\n\n\n"+file_paths.to_yaml+"\n\n\n"

    render file: path+'/client/src/client/index.html'
  end
end
