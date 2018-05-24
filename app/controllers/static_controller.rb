class StaticController < ApplicationController

  include ActionDispatch

  def index
    render file: "public/index.html"
  end
end
