
class UsersController < ApplicationController
  def new
  end

  def show
    json_response(User.find(params[:id]))
  end
end