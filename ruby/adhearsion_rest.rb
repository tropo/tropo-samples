#==========
#Example that allows you to use Adhearsion (http://adhearsion.com)
#via REST with Tropo
#==========
require 'json'
require 'rest_client'
 
class RESTfulAdhearsion
  
  DEFAULT_OPTIONS = {
    # Note: :user and :password are non-existent by default
    :host => "localhost",
    :port => "5000",
    :path_nesting => "/"
  }
  
  def initialize(options={})
    @options = DEFAULT_OPTIONS.merge options
    
    @path_nesting = @options.delete :path_nesting
    @host = @options.delete :host
    @port = @options.delete :port
    
    @url_beginning = "http://#{@host}:#{@port}#{@path_nesting}"
  end
  
  def method_missing(method_name, *args)
    JSON.parse RestClient::Resource.new(@url_beginning + method_name.to_s, @options).post(args.to_json)
  end
  
end

#Create our Adhearsion object connected to the RESTful API of Adhearsion
Adhearsion = RESTfulAdhearsion.new(:host => "localhost",
                                   :port => 5000,
                                   :user => "jicksta",
                                   :password => "roflcopterz")

answer 

#The session GUID is passed as the callerid, since this is a 'private network' call
#Invoke an RPC method via Adhearsion to fetch the menu and event handling for Tropo
request = Adhearsion.get_request($currentCall.callerID)

options = { :choices     => request[:options][:choices],
            :repeat      => request[:options][:repeat],
            :timeout     => request[:options][:timeout],
            :onBadChoice => lambda { say request[:options][:onBadChoice] },
            :onTimeout   => lambda { say request[:options][:onTimeout] },
            :onChoice    => lambda { |choice| eval request[:options][:onChoice] } }
begin
  #Execute the request
  ask request[:text], options
rescue => err
  log '============>' + err + '<============'
end

hangup