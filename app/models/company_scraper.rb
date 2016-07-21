class CompanyScraper
  require 'open-uri'
  attr_reader :url

  def nokogiri_document
    data = open(url).read
    @nokogiri_document ||= Nokogiri::HTML(data)
  end

  def get_companies
    company_section = nokogiri_document.css("div[@data-argument-name='company']")
    companies = company_section[1].elements[0].elements[0].elements.map{ |elem| elem.text }
  end

  private

  def url
    @url ||= "https://www.themuse.com/developers/api/v2"
  end
end