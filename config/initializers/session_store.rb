# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_optibuilder_session',
  :secret      => 'e8d22982b36a759fe1074750c4e27b093c523557f7ab70be7243dd4a6ec7baf85b748fd33dac327dd12b7c499d242ac53739c337386e5858362c14bb28f166dd'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
