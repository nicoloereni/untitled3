require_relative '../lib/cookie.rb'

@url = 'https://tickets.events.ccc.de/36c3/'

Cookie.new(@url).ask_until_get(4, 'intro_seen_36c3') do
  p 'DONE!'
end
# Cookie.new(@url).ask_until_get(4, '36C3Queue')
# Cookie.new(@url).ask_until_get(4, 'pretix_csrftoken')