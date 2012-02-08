require 'rubygems'
require 'mechanize'

module Mac

  Event = Struct.new(:name, :url, :date, :score)

  def events
    events = []
    agent = Mechanize.new
        page  = agent.get('http://musicalartsconference.com/members/Guard/Naugatuck-HS-Winter-Guard.html')
        page.search("div[@class='about_page'] table tr")[1..-1].each do |row|
          name_row = row.search("td a")
          name     = name_row.inner_html
          url      = "http://musicalartsconference.com#{name_row.first.attributes["href"].value}"
          tds = row.search("td").map {|td| td.inner_html }

          next if name[/Beecher/i] # Skip Beecher

          event = Event.new(name, url, tds[1], tds[2])

          events << event
        end

    events
  end

end