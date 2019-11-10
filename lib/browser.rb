require 'watir'
require 'webdrivers'
require 'faker'

class Browser
  def initialize(url)
    @url = url
    @browser = Watir::Browser.new(:firefox)
  end

  def open
    @browser.goto(@url)
    @browser.cookies.add 'foo', 'bar', path: '/path', expires: (Time.now + 10000), secure: true
    p @browser.cookies.to_a
    # @browser.goto(@url)
  end
end