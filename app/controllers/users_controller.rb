
class UsersController < ApplicationController
  def new
  end

  def show
    byebug
    json_response(User.find(params[:id]))
  end
end