module Dropbox
  class Browser

    def dropbox_client=(client)
      @dropbox_client = client
    end

    def dropbox_client
      @dropbox_client ||= new_dropbox_client
    end

    def ls( path = nil )
      path ||=spree_config[:dropbox_root_path]
      files = []
      response = dropbox_client.metadata(path)
      files = parse_metadata(response["contents"], response["path"])
      return files
    end

    def search( query, path = nil )
      path ||=spree_config[:dropbox_root_path]
      response = dropbox_client.search(path, query)
      files = parse_metadata(response, path)
      return files
    end

    private

    def parse_metadata(files, path)
      files.collect do |resp|
        {
          :name => resp["path"].gsub(/^#{path}\//, ""),
          :file_size => resp["bytes"],
          :content_type => resp["mime_type"]
        }
      end
    end

    def spree_config
      @spree_config ||= Spree::SpreeDigitalConfiguration.new
    end

    def new_dropbox_client
      credentials = spree_config
      credentials[:dropbox_access_type] ||= "dropbox"
      session = DropboxSession.new(credentials[:dropbox_app_key], credentials[:dropbox_app_secret])
      session.set_access_token(credentials[:dropbox_access_token], credentials[:dropbox_access_token_secret])
      DropboxClient.new(session, credentials[:dropbox_access_type])
    end
  end
end
