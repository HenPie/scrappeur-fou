require 'nokogiri'
require 'open-uri'
require 'pry'

def get_depute_emails(depute_url)
  page = Nokogiri::HTML(URI.open(depute_url))   
  return page.xpath('//*[@id="b1"]/ul[2]/li[1]/ul/li[1]/a').text
end

def get_depute_info
  depute_names =[]
  depute_urls = []
  page = Nokogiri::HTML(URI.open("https://www.nosdeputes.fr/deputes"))  
  page.xpath('//*[@class="list_dep jstitle phototitle block"]').each do |var|
    depute_names <<  var.children[3].text.delete(" ").split(",")
    depute_urls << "https://www.nosdeputes.fr" + var.parent["href"]
  end
  return [depute_urls, depute_names]
end


def info_deputes 
    depute_urls = get_depute_info[0]
    depute_names = get_depute_info[1]
  hash_depute = [] 

  depute_urls.each_with_index do |depute_url,i|
    hash_depute << { "first_name" => depute_names[i][1],"family_name" => depute_names[i][0][1..-1], "email" => get_depute_emails(depute_url)}
    end
  return hash_depute
end

