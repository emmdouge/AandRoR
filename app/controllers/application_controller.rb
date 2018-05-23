
require 'google/apis/people_v1'
require 'google/api_client/client_secrets.rb'

class ApplicationController < ActionController::Base

  include Response
  include ExceptionHandler
  include Session
  
  # The user's preexisting session (i.e. as set by other, traditional controllers) will remain intact
  protect_from_forgery with: :null_session

  # before_filter :session_expires, :except => [:login, :logout] 
  # before_filter :update_session_time, :except => [:login, :logout]

  # calls before filter on every action in the api  
  # if not redirectd to halt filter chain, update session
  before_action :session_expired, :except => [:google_oauth2]
  # prepend_before_action :session_expired, :except => [:google_oauth2]

  People = Google::Apis::PeopleV1
  
  # A route that when queried, returns the contact list of your authenticated user. Let’s break down the route a bit.
  def contacts
    secrets = Google::APIClient::ClientSecrets.new(
      {
        "web" =>
          {
            "access_token" => current_user.token,
            "refresh_token" => current_user.refresh_token,
            "client_id" => Rails.application.secrets[:google_client_id],
            "client_secret" => Rails.application.secrets[:google_secret]
          }
      }
    )
    service = People::PeopleServiceService.new

    # secrets.to_authorization returns a Signet::OAuth2::Client object for our service
    service.authorization = secrets.to_authorization

    response = service.list_person_connections(
      'people/me',
       person_fields: ['names', 'emailAddresses', 'phoneNumbers']
    )
    render json: response
  end
end