module Spree
  class SpreeDigitalConfiguration < Preferences::Configuration
    # number of times a customer can download a digital file
    preference :authorized_clicks,  :integer, :default => 3

    # number of days after initial purchase the customer can download a file
    preference :authorized_days,    :integer, :default => 2

    # should digitals be kept around after the associated product is destroyed
    preference :keep_digitals,      :boolean, :default => false

    #number of seconds before an s3 link expires
    preference :s3_expiration_seconds,    :integer, :default => 10

    preference :preserve_files, :boolean, :default => false

    #dropbox preferences
    preference :use_dropbox, :boolean, :default => false
    preference :dropbox_visibility, :string, :default => "public"
    preference :dropbox_app_key, :string
    preference :dropbox_app_secret, :string
    preference :dropbox_access_token, :string
    preference :dropbox_access_token_secret, :string
    preference :dropbox_user_id, :string
    preference :dropbox_access_type, :string
    preference :dropbox_root_path, :string
  end
end
