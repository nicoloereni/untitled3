require_relative '../lib/cookie.rb'
require_relative '../lib/browser.rb'
require 'active_support'

@url = 'https://tickets.events.ccc.de/36c3/'

# Cookie.new(@url).extract_until_get(4, 'intro_seen_36c3') do
#   p 'DONE!'
#   Browser.new(@url).open
#   sleep(3600)
# end

Cookie.new(@url).extract_until_get(4, '36C3Queue') do
  p 'DONE!'
  Browser.new(@url).open
  sleep(3600)
end
#
# Cookie.new(@url).extract_until_get(4, 'pretix_csrftoken') { p 'DONE!' }