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
    student_url = Nokogiri::HTML(open(profile_url))
    social_media = student_url.css(".social-icon-container")
    url_array = social_media.children.css("a").collect { |a| a.attribute("href").text}
    profile_hash = {}
    url_array.each do |url|
      if url.include?("twitter")
        profile_hash[:twitter] = url
      elsif url.include?("linkedin")
        profile_hash[:linkedin] = url
      elsif url.include?("github")
        profile_hash[:github] = url
      else
        profile_hash[:blog] = url
      end
    end
    profile_hash[:profile_quote] = student_url.css(".profile-quote").text
    profile_hash[:bio] = student_url.css(".bio-block p").text
    profile_hash
  end

end
