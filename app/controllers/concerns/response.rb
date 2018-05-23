# app/controllers/concerns/response.rb
# shared by all controllers because it is stored in concerns
module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end
end