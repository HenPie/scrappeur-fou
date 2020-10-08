require 'nokogiri'
require 'open-uri'
require 'pry'


def get_townhall_url
  doc = Nokogiri::HTML(URI.open('http://annuaire-des-mairies.com/val-d-oise.html'))
  get_url = doc.xpath('//a[@class="lientxt"]')
  townhall_urls = []
  get_url.each do |townhall|
    url = townhall.attribute('href').text
    townhall_urls << url
    
  end
  townhall_urls
end

def get_townhall_email(url,hash)
  doc = Nokogiri::HTML(URI.open(url))
  townhall_emails = doc.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
  townhall_cities = doc.xpath('//a[@class="lientxt4"]').text
  hash[townhall_cities] = townhall_emails
  
end

def get_townhalls_emails(pages)
  townhall_info = []
  townhall_cities_emails = Hash.new
  pages.each {|page| get_townhall_email("http://annuaire-des-mairies.com/#{page}",townhall_cities_emails)}
  p townhall_cities_emails
  
  townhall_info
end

def perform 
  pages = get_townhall_url
  get_townhalls_emails(pages)
end

perform

