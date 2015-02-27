require 'rubygems'
require 'mechanize'

module Scores

  Event = Struct.new(:name, :url, :date, :score)

  def events
    events = mac_events
    # events += us_bands_events

    events.sort_by(&:date)
  end

  private

  def mac_events
    events = []
    agent = Mechanize.new
    # Marching Band
    # http://musicalartsconference.com/members/Marching-Band/Naugatuck-High-School.html
    # Color Guard
    # http://musicalartsconference.com/members/Guard/Greyhound-Winter-Guard.html
    # http://musicalartsconference.com/members/Guard/Naugatuck-Winter-Guard.html
    page  = agent.get('http://musicalartsconference.com/members/Guard/Naugatuck-Winter-Guard.html')

    page.search("div[@class='about_page'] table tr")[1..-1].each do |row|
      name_row = row.search("td a")
      next if name_row.nil?
      name     = name_row.inner_html
      url      = "http://musicalartsconference.com#{name_row.first.attr("href")}"
      tds = row.search("td").map {|td| td.inner_html }

      event = Event.new(name.strip, url, tds[1], tds[2])

      # case event.name
      # when "Jonathan Law High School"
      #   event.score = "89.60"
      # when "Norwalk High School"
      #   event.score = "Canceled"
      # end

      events << event
    end

    events
  end

  # Manual since we are only doing one show and I can't easily determine how
  # scores are posted
  #
  def us_bands_events
    event = Event.new("Bunnell High School",
      "http://trigonroad.com/yea/eventInfo.cfm?id=439",
      "10-26-12",
      "86.00")

    []
  end

end
