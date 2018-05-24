class StaticController < ApplicationController

  include ActionDispatch

  def index
    redirect_to home_path
  end
end
