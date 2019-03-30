require 'open-uri'
require 'pry'

class Scraper

def self.scrape_index_page(index_url)
  students = Nokogiri::HTML(open(index_url))
  student_card_container = students.css(".roster-cards-container")
  #student_data = student_card_container.css(".student-card a")
  student_card_container.collect do |student|
    {
    :name => student.css(".student-name").text,
    :location => student.css(".student-location").text,
    :profile_url => student.css("a").attribute("href").text
  }
  end
end

  def self.scrape_profile_page(profile_url)

  end

end
