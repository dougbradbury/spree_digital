require 'paperclip-dropbox'

module Spree
  module Core
    module DropboxSupport
      extend ActiveSupport::Concern

      included do
        def self.supports_dropbox(field)
          # Load user defined paperclip settings
          config = Spree::SpreeDigitalConfiguration.new
          if config[:use_dropbox]
            dropbox_creds = {
              app_key: config[:dropbox_app_key],
              app_secret: config[:dropbox_app_secret],
              access_token: config[:dropbox_access_token],
              access_type: config[:dropbox_access_type]}

            self.attachment_definitions[field][:storage] = :dropbox
            self.attachment_definitions[field][:path] = "#{config[:dropbox_root_path]}/:filename"
            self.attachment_definitions[field][:dropbox_credentials] = dropbox_creds
            self.attachment_definitions[field][:dropbox_visibility] = config[:dropbox_visibility]
          end
        end
      end
    end
  end
end
