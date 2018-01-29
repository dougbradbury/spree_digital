require 'spec_helper'

RESPONSE_HASH = {
  "path"=>"/_testScripts",
  "is_dir"=>true,
  "root"=>"dropbox",
  "contents"=>[
    {
      "bytes"=>95536,
      "modified"=>"Fri, 13 Dec 2013 03:17:05 +0000",
      "client_mtime"=>"Fri, 13 Dec 2013 03:17:05 +0000",
      "path"=>"/_testScripts/227L_-_Cover.pdf",
      "is_dir"=>false,
      "root"=>"dropbox",
      "mime_type"=>"application/pdf",
      "size"=>"93.3 KB"
    }, {
      "bytes"=>99423,
      "modified"=>"Tue, 10 Dec 2013 03:49:25 +0000",
      "client_mtime"=>"Tue, 10 Dec 2013 03:49:25 +0000",
      "path"=>"/_testScripts/app/_testScripts/316P_-_Cover.pdf",
      "is_dir"=>false,
      "root"=>"dropbox",
      "mime_type"=>"application/wat_foo",
      "size"=>"97.1 KB"
    }
  ]
}

describe Spree::Admin::DropboxBrowserController do
  stub_authorization!
  before(:each) do
    Spree::SpreeDigitalConfiguration.new.set(:dropbox_root_path => "foo")
    controller.dropbox_client = double(:dropbox_client)
  end

  context "successful metadata call" do
    before(:each) do
      controller.dropbox_client.should_receive(:metadata).with("foo").and_return(RESPONSE_HASH)
    end

    it "lists dropbox file contents" do
      spree_get :ls
      assigns[:files].size.should == 2
    end

    it "lists filenames of a dropbox directory" do
      spree_get :ls
      assigns[:files].collect{ |file| file[:name] }.should =~ ["227L_-_Cover.pdf", "app/_testScripts/316P_-_Cover.pdf"]
    end

    it "lists sizes of a dropbox directory" do
      spree_get :ls
      assigns[:files].collect{ |file| file[:file_size] }.should =~ [95536, 99423]
    end

    it "lists mime_types of a dropbox directory" do
      spree_get :ls
      assigns[:files].collect{ |file| file[:content_type] }.should =~ ["application/wat_foo", "application/pdf"]
    end
  end

  context "successful search call" do
    before(:each) do
      controller.dropbox_client.should_receive(:search).with("foo", "query").and_return(RESPONSE_HASH["contents"])
    end

    it "searchs" do
      spree_get :search, :query => "query"
      assigns[:files].size.should == 2
    end
  end

  it "handles dropbox errors" do
    controller.dropbox_client.should_receive(:list_folder).and_raise(DropboxApi::Errors::BasicError.new("problem"))
    spree_get :ls
    assigns[:error].should be_a(DropboxApi::Errors::BasicError)
  end

end
