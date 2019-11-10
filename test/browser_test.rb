require 'test/unit'
require_relative '../lib/browser.rb'

class BrowserTest <  Test::Unit::TestCase
  test 'open' do
    Browser.new('https://tickets.events.ccc.de/36c3/').open

    sleep(1000)
  end
end