#==========
#Example that allows you to use Adhearsion (http://adhearsion.com)
#via DRb with Tropo
#==========
require 'drb'

#Connect to your Adhearsion instance running across the internets
#In the future this will be REST
Adhearsion = DRbObject.new_with_uri 'druby://yourhost.net:9050'

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