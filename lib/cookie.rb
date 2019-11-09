require 'mechanize'

OUTPUT_PATH = 'output'

class Cookie
  def initialize(url)
    @url = url
    @agent = Mechanize.new
  end

  def ask(cookie_name, output_path: OUTPUT_PATH)
    p '.'

    @agent.get(@url)
    @agent.cookies
        .select { |c| c.name == cookie_name }
        .each { |c| write_file(output_path, c) }
        .map{ |e| e.to_s }
  end

  def ask_until_get(number, cookie_name, output_path: OUTPUT_PATH)
    counter = 0
    until number == counter
      res = ask(cookie_name, output_path: output_path)
      counter += 1 unless res.empty?
    end
    yield
  end

  private

  def write_file(path, cookie)
    p cookie.to_s
    File.write("#{path}/cookie_#{rand(10000)}", cookie.to_s)
  end
end