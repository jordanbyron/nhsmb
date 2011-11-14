require 'rubygems'
require 'mechanize'

module Mac

  Event = Struct.new(:name, :url, :date, :score)

  def events
    events = [
      Event.new("Brookfield High School",   nil, nil, "69.20"),
      Event.new("Trumbull High School",     nil, nil, "73.10"),
      Event.new("Shelton High School",      nil, nil, "79.90"),
      Event.new("Connecticut Open",         nil, nil, "79.70"),
      Event.new("Jonathan Law High School", nil, nil, "Canceled"),
      Event.new("Norwalk High School",      nil, nil, "84.20"),
      Event.new("MAC Championships",
        "http://musicalartsconference.com/events/11122011/MAC-Championships.html",
        nil, 88.00 )
    ]
    # agent = Mechanize.new
    #     page  = agent.get('http://musicalartsconference.com/members/Marching-Band/Naugatuck-High-School.html')
    #     page.search("div[@class='about_page'] table tr")[1..-1].each do |row|
    #       name_row = row.search("td a")
    #       name     = name_row.inner_html
    #       url      = "http://musicalartsconference.com#{name_row.first.attributes["href"].value}"
    #       tds = row.search("td").map {|td| td.inner_html }
    #
    #       next if name[/Naugatuck/i] # Skip Naugatuck since we were in Exhibition
    #
    #       event = Event.new(name, url, tds[1], tds[2])
    #
    #       events << event
    #     end

    events
  end

end