require 'open-uri'
require 'pry'

class Scraper

def self.scrape_index_page(index_url)
  students = Nokogiri::HTML(open(index_url))
  student_array = []
  students.css(".roster-cards-container").each do |card|
    card.css(".student-card a").each do |student|
      student_array << {
      :name => student.css(".student-name").text,
      :location => student.css(".student-location").text,
      :profile_url => student.attribute("href").text
    }
    end
  end
  student_array
end

  def self.scrape_profile_page(profile_url)

  end

end
