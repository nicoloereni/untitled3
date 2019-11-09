require_relative '../lib/cookie.rb'

@url = 'https://tickets.events.ccc.de/36c3/'

# Cookie.new(@url).ask_until_get(4, 'intro_seen_36c3') { p 'DONE!' }

Cookie.new(@url).ask_until_get(4, '36C3Queue') { p 'DONE!' }
# Cookie.new(@url).ask_until_get(4, 'pretix_csrftoken') { p 'DONE!' }