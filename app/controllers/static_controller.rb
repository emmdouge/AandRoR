require 'find'
class StaticController < ApplicationController

  include ActionDispatch

  def index
    file_paths = Find.find(Rails.root).select { |p| /.*ngsw.json$/ =~ p }
    puts "\n\n\n"+file_paths.to_yaml+"\n\n\n"
    render file: "/client/dist/prod/index.html"
  end
end
