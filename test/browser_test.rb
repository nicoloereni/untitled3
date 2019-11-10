require 'test/unit'
require_relative '../lib/browser.rb'

class BrowserTest <  Test::Unit::TestCase

  setup do
    @browser = Browser.new('https://tickets.events.ccc.de/36c3/')
  end

  test 'open' do
    Dir.mktmpdir do |tmpdir|
      File.write("#{tmpdir}/cookie_123", cookies)
      assert_equal(
          expected_cookies,
          @browser.open(cookie_path: "#{tmpdir}/cookie_*"))

    end
  end

  test 'read cookies' do
    Dir.mktmpdir do |tmpdir|
      File.write("#{tmpdir}/cookie_123", cookies)
      assert_equal(
          [{name: 'intro_seen_36c3', value: 'false'}, {name:'pippo', value:'ciao'}],
          @browser.read_cookies("#{tmpdir}/cookie_*"))
    end
  end

  private

  def expected_cookies
    [{:domain=>"tickets.events.ccc.de",
      :expires=>nil,
      :name=>"intro_seen_36c3",
      :path=>"/",
      :secure=>false,
      :value=>"false"},
     {:domain=>"tickets.events.ccc.de",
      :expires=>nil,
      :name=>"pippo",
      :path=>"/",
      :secure=>false,
      :value=>"ciao"}]
  end

  def cookies
    <<-STRING
intro_seen_36c3=false
pippo=ciao
    STRING
  end
end