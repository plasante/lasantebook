# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_book_shelf_session',
  :secret      => '9be66633fd706c37073e02240389e6613175b005ff36046b4361f74b7098f5f9524676cb76ef3cd90284ab77f5d7f656f82e8fd82cbed345f66768a0da281bfa'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
