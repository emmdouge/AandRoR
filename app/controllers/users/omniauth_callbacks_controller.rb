# app/controllers/users/omniauth_callbacks_controllers.rb
require "base64"

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # skip session_expires filter defined in application controller
  # https://stackoverflow.com/questions/5711797/how-can-i-specify-the-order-that-before-filters-are-executed?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa

  # The user's preexisting session (i.e. as set by other, traditional controllers) will remain intact
  # protect_from_forgery with: :null_session

  # Devise expects that the action name matches the omniauth you are using
  def google_oauth2
    # Schema for omni-auth hash
    # https://github.com/omniauth/omniauth/wiki/Auth-Hash-Schema
    # Cookie vs Token-based authentication
    # https://auth0.com/blog/angularjs-authentication-with-cookies-vs-token/
    # https://www.quora.com/What-is-the-difference-between-sessionstorage-localstorage-and-Cookies
    expire_time = Time.current + 24.hours
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      # session[:user_id] = @user.id
      # session[:expires_at] = Time.current + 60.minutes
      puts "\n\n\n USER PERSISTED \n\n\n"
      # delete it since it is unedittable if stored
      # must include domain if that is specified in the cookie stored
      # cookies.delete(:key, :domain => 'domain.com')
      cookies.delete(:cube_user)
      cookies.delete(:auth_token)
      # .signed prevents cookie from external modification
      # .encrypted disables modification and viewing(?)
      # did not use cookies.signed[:cube_user] because there was too much garbage attached
      cookies[:cube_user] = {
        # .chomp does newlines and carriage returns
        # .squish removes newlines and spaces
        :value => Base64.encode64(@user.id.to_s).squish.tr('=', ''),
        # :expires => 1.year.from_now,
        :expires => Time.current + 60.minutes,
        # :domain => 'http://localhost:4200'
      }
      cookies[:auth_token] = {
        # .chomp does newlines and carriage returns
        # .squish removes newlines and spaces
        :value => @user.token,
        # :expires => 1.year.from_now,
        :expires => Time.current + 60.minutes,
        # :domain => 'http://localhost:4200'
      }
      sign_in @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
    else
      byebug
      session["devise.google_data"] = request.env["omniauth.auth"]
    end
    # url needs http://
    # keeps session since the domain is localhost
    url = "http://localhost:3000"
    p = params.merge({:user => @user})
    # redirect_to url p
    # GOOGLE LOGIN
    redirect_to(url, p)
  end

end