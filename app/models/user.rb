class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
  
  # Suggests to Devise that the model was manually created with "database_authenticable" fields to interact with OmniAuth table (Model)
  # and registers that it’s an omniauthable model and has extra functionality. 
  # Removed the common database_authenticatable, but you can keep it if you need to also do auth with the database.
  devise :database_authenticatable, :omniauthable, :omniauth_providers => [:google_oauth2]

  # we will want to be able to create a User from the hash
  # received from with our authentication parameter (Google) 
  def self.from_omniauth(auth)
    # Either create a User record or update it based on the provider (Google) and the UID   
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      # https://github.com/omniauth/omniauth/wiki/Auth-Hash-Schema
      user.token = auth.credentials.token
      user.expires = auth.credentials.expires
      user.expires_at = auth.credentials.expires_at
      user.refresh_token = auth.credentials.refresh_token
      user.name = auth.info.name
      user.email = auth.info.email
      user.encrypted_password = Devise.friendly_token[0,20]
    end
  end
end
