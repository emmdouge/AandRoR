class StaticController < ApplicationController
  def index
    static("index.html")
  end
end
