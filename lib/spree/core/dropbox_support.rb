module Spree
  module Core
    module DropboxSupport
      extend ActiveSupport::Concern

      included do
        def self.supports_dropbox(field)
          # Load user defined paperclip settings
          config = Spree::SpreeDigitalConfiguration.new
          if config[:use_dropbox]
            self.attachment_definitions[field][:storage] = :dropbox
            self.attachment_definitions[field][:app_key] = :dropbox
            self.attachment_definitions[field][:app_secret] = config[:dropbox_key]
            self.attachment_definitions[field][:access_token] = config[:dropbox_token]
            self.attachment_definitions[field][:user_id] = config[:dropbox_user]
            self.attachment_definitions[field][:access_token_secret] = config[:dropbox_token_secret]
            self.attachment_definitions[field][:access_type] = "app_folder"
          end
        end
      end
    end
  end
end
