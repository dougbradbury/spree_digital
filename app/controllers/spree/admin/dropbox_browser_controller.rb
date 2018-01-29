module Spree
  class Admin::DropboxBrowserController < Spree::Admin::BaseController
    layout false

    def dropbox_client=(client)
      browser.dropbox_client = client
    end

    def dropbox_client
      browser.dropbox_client
    end

    def ls
      @files = browser.ls
    rescue DropboxApi::Errors::BasicError => e
      @error = e
    end

    def search
      @files = browser.search(params[:query])
      render :ls
    rescue DropboxApi::Errors::BasicError => e
      @error = e
    end


    private

    def browser
      @browser ||= Dropbox::Browser.new
    end

  end
end

