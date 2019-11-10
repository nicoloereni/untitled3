require 'watir'
require 'webdrivers'
require 'faker'

class Browser
  def initialize(url)
    @url = url
    @browser = Watir::Browser.new(:firefox)
  end

  def open(cookie_path: "output/cookie_*")
    @browser.goto(@url)
    read_cookies(cookie_path).each do |c|
      @browser.cookies.add c[:name], c[:value]
    end
    p @browser.cookies.to_a
  end

  def read_cookies(path)
    res = []
    File.read(Dir[path].sort.first).split("\n").each do |l|
      p = l.partition('=')
      res << {name: p[0], value: p[2]}
    end
    res
  end
end