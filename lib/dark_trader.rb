require 'nokogiri'
require 'open-uri'
require 'pry'

def get_crypto_symbol
  page = Nokogiri::HTML(URI.open('https://coinmarketcap.com/all/views/all/'))
  crypto_symbol = page.xpath('//*[@id="__next"]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div')
  crypto_symbols = crypto_symbol.map { |crypto| crypto.text }
end

def get_crypto_price
  page = Nokogiri::HTML(URI.open('https://coinmarketcap.com/all/views/all/'))
  crypto_price = page.xpath('//*[@id="__next"]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/a')
  crypto_prices = crypto_price.map { |crypto| crypto.text }
end

def get_crypto
  crypto_symbols = get_crypto_symbol
  crypto_prices = get_crypto_price
  cryptocurrencies = Hash.new
  cryptocurrencies = Hash[crypto_symbols.zip(crypto_prices)]
  puts "On a fusionné nos arrays en hash"
  puts cryptocurrencies
end
