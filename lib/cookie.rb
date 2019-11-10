require 'mechanize'

OUTPUT_PATH = 'output'

class Cookie
  def initialize(url)
    @url = url
    @agent = Mechanize.new
    @all_cookies_path = ''
  end

  def all_cookies_path
    @all_cookies_path
  end

  def extract(cookie_name, output_path: OUTPUT_PATH)
    @all_cookies_path = "#{output_path}/cookies_all_#{self.__id__}"
    File.write(@all_cookies_path, '') unless File.exist?(@all_cookies_path)

    write_file_in_all(@all_cookies_path, "#{'-' * 30}")

    @agent.get(@url)
    @agent.cookies
        .each { |c| write_file_in_all(@all_cookies_path, c)}
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

  def write_file_in_all(path, cookie)
    File.write("#{path}", format(cookie.to_s), File.size("#{path}"), mode: 'a')
  end

  def write_file(path, cookie)
    File.write("#{path}/cookie_#{Time.now.to_f}", cookie.to_s)
  end

  def format(s)
    <<-STRING
#{s.to_s}
STRING
  end
end