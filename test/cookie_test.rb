require 'test/unit'
require_relative '../lib/cookie.rb'

class CookieTest < Test::Unit::TestCase
  test 'ask' do
    Dir.mktmpdir do |tmpdir|
      cookie_name = 'intro_seen_36c3'
      res = Cookie.new('https://tickets.events.ccc.de/36c3/').ask(cookie_name, output_path: tmpdir)

      assert_equal(['intro_seen_36c3=true'], res)
      assert_equal(1, Dir[tmpdir].count)
      Dir["#{tmpdir}/*"].each do |f|
        assert_equal(true, File.read("#{f}").include?(cookie_name))
      end
    end
  end

  test 'ask not existing cookie' do
    assert_equal([], Cookie.new('https://tickets.events.ccc.de/36c3/').ask('not_existing'))
  end

  test 'ask until get 3 results' do
    Dir.mktmpdir do |tmpdir|
      Cookie.new('https://tickets.events.ccc.de/36c3/')
          .ask_until_get(3, 'intro_seen_36c3', output_path: tmpdir) do
        assert_equal(3, Dir["#{tmpdir}/*"].count)
      end
    end
  end
end