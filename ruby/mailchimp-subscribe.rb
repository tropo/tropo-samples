# Copyright Tropo, part of Cisco
# Released under the MIT license. See the file LICENSE
# for the complete license

list = '' # Your list ID http://kb.mailchimp.com/lists/managing-subscribers/find-your-list-id
apikey = '' # Your mailchimp API key http://kb.mailchimp.com/integrations/api-integrations/about-api-keys

if $currentCall.initialText != 'TEXT'
  reject
end

if email = /\S+@\S+/.match($currentCall.initialText)
  email = email.to_s.strip
  say "I've added #{email} to our email list. Check your email to confirm your subscription."

  require 'rest-client'
  require "base64"
  dc = /-(.*)$/.match(apikey).captures
  auth = Base64.encode64 "user:#{apikey}"
  url = "https://#{dc[0]}.api.mailchimp.com/3.0/lists/#{list}/members"
  data = {'email_address' => email, 'status' => 'pending'}.to_json
  resp = RestClient.post url, data, { content_type: :json, accept: :json, Authorization: "Basic #{auth}" }
else
  say "Tell me your email address and I'll add you to our email list."
end