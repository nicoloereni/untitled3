require 'mechanize'

OUTPUT_PATH = 'output'

class Cookie
  def initialize(url)
    @url = url
    @agent = Mechanize.new
  end

  def extract(cookie_name, output_path: OUTPUT_PATH)
    @agent.get(@url)
    @agent.cookies
        .select { |c| c.name == cookie_name }
        .each { |c| write_file(output_path, c) }
        .map{ |e| e.to_s }
  end

  def extract_until_get(number, cookie_name, output_path: OUTPUT_PATH)
    counter = 0
    until number == counter
      p "#{Time.now.to_f}"
      res = extract(cookie_name, output_path: output_path)
      counter += 1 unless res.empty?
      sleep(0.01)
    end
    yield
  end

  private

  def write_file(path, cookie)
    File.write("#{path}/cookies_all", format(cookie), File.size("#{path}/cookies_all"), mode: 'a')
    File.write("#{path}/cookie_#{Time.now.to_f}", cookie.to_s)
  end

  def format(s)
    <<-STRING
#{'-' * 30}
#{s.to_s}
STRING
  end
end