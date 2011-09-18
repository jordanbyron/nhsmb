require 'rubygems'
require 'mechanize'

module Mac

  def events
    event  = Struct.new(:name, :url, :date, :score)
    events = []
    agent = Mechanize.new
    page  = agent.get('http://musicalartsconference.com/members/Marching-Band/Naugatuck-High-School.html')
    page.search("div[@class='about_page'] table tr")[1..-1].each do |row|
      name_row = row.search("td a")
      name     = name_row.inner_html
      url      = "http://musicalartsconference.com#{name_row.first.attributes["href"].value}"
      tds = row.search("td").map {|td| td.inner_html }

      events << event.new(name, url, tds[1], tds[2])
    end

    events
  end

end