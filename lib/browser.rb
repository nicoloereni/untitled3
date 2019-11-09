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
  end
end