require 'dropbox_sdk'
module Spree
  class DigitalsController < Spree::StoreController
    ssl_required :show

    def show
      link = DigitalLink.find_by_secret(params[:secret])

      if link.present? and link.digital.attachment_file_name.present?
        file = link.digital.attachment_file_name
        if link.authorize!
          client = DropboxClient.new(Spree::Config[:dropbox_token], :dropbox)
          redirect_to client.media(file)['url']
        else
          render :unauthorized
        end
      else
        Rails.logger.error "Missing Digital Item: #{file}"
      end
    # rescue DropboxError => e
    #   Rails.logger.error "Dropbox Error: '#{e.message}' for file #{file}"
    #   render :unauthorized
    end

  end
end
