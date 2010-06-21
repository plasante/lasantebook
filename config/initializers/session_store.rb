# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_lasante_book_session',
  :secret      => '5ba3d623d37958d5ad641a9fd00e61f468dd5b9d4b2ab809c0ddf555bef96f7ee520183e29a5ac15dda2db3723a94c7d31d4a3fa3f1a618938b1e71fee4bcd8a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
