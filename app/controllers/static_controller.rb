class StaticController < ApplicationController

  include ActionDispatch

  def index
    render file: "/client/dist/prod/index.html"
  end
end
