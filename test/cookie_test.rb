require 'test/unit'
require_relative '../lib/cookie.rb'

class CookieTest < Test::Unit::TestCase
  setup do
    @cookie = Cookie.new('https://tickets.events.ccc.de/36c3/')
  end

  test 'extract' do
    Dir.mktmpdir do |tmpdir|
      cookie_name = 'intro_seen_36c3'
      res = @cookie.extract(cookie_name, output_path: tmpdir)

      assert_equal(['intro_seen_36c3=true'], res)
      assert_equal(2, Dir["#{tmpdir}/*"].count)
      Dir["#{tmpdir}/*"].each do |f|
        assert_equal(true, File.read("#{f}").include?(cookie_name))
      end
    end
  end

  test 'extract not existing cookie' do
    assert_equal([], @cookie.extract('not_existing'))
  end

  test 'extract until get 3 results' do
    Dir.mktmpdir do |tmpdir|
      @cookie.extract_until_get(3, 'intro_seen_36c3', output_path: tmpdir) do
        assert_equal(4, Dir["#{tmpdir}/*"].count)
        assert_equal(
            true,
            File.read(@cookie.all_cookies_path).include?('intro_seen_36c3=true'))
      end
    end
  end
end