require 'date'
# shared by all controllers because it is stored in concerns
module Session
  def session_expired
    # this forces load of the session by writing to it
    # session["force_init"] = true
    puts "\n\n\n SESSION EXPIRE \n\n\n"
    # request.session_options[:id]
    # request.env["rack.request.cookie_hash"]
    # request.cookies
    # session[:session_id]
    @users = User.where(token: params[:auth_token]).first
    if @users.nil? || DateTime.strptime(@users.expires_at.to_s,'%s') < Time.now
      byebug 
      # redirect_to :controller => 'users/omniauth_callbacks', :action => 'google_oauth2'
      redirect_to 'http://localhost:4200/login'
    end
  end

end