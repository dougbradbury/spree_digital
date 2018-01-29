require 'dropbox_api'

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
      response = dropbox_client.list_folder(path)
      collect_files(response.entries)
    end

    def search( query, path = nil )
      path ||=spree_config[:dropbox_root_path]
      response = dropbox_client.search(query, path)
      files = response.matches.collect do |match|
        match.resource
      end
      return collect_files(files)
    end

    private

    def collect_files(response)
      files = response.collect do |file|
        resp = file.to_hash
        {
          :name => resp["name"],
          :file_size => resp["size"],
          :content_type => ""
        }
      end

      return files
    end
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
      DropboxApi::Client.new(credentials[:dropbox_access_token])
    end
  end
end
