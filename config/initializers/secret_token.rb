# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.

# Although this is not needed for an api-only application, rails4 
# requires secret_key_base or secret_token to be defined, otherwise an 
# error is raised.
# Using secret_token for rails3 compatibility. Change to secret_key_base
# to avoid deprecation warning.
# Can be safely removed in a rails3 api-only application.
InteractionDrivenDesign::Application.config.secret_token = '18dfc0b36d539cfdee24f4d7bb18c2e988d869cae1c259c7a8c0d62cfcfcd79b0c2269cfa3f56c7a5f2f22cf1e1d98d0e95cec499cee7d6c26c4ffd8201a84a9'
