require_relative "base"
require "nokogiri"


module Fetchers
  class Stock < Base
    BASE_URL = "http://www.google.com"
    KEY = 'Fmjtd%7Cluua2d6t2u%2Cb5%3Do5-hr85g'
    MAPS_URL = "http://www.mapquestapi.com/traffic/v1/incidents?key=#{KEY}&callback=handleIncidentsResponse&boundingBox=39.503136,-76.887259,39.077998,-76.337942&filters=incidents&inFormat=kvp&outFormat=xml"

  
    
  uri = URI.parse(MAPS_URL)
      response = Net::HTTP.get_response(uri)
      quote = Nokogiri::XML(response.body)
      incidents = quote.xpath("//Incidents").attribute("data").value
      #volume = quote.xpath("//volume").attribute("data").value
      #percent_change = quote.xpath("//perc_change").attribute("data").value
      #url = BASE_URL + quote.xpath("//symbol_lookup_url").attribute("data").value
         
   @data = {
          incidents: incidents,
          # volume: volume,
          # percent_change: percent_change,
          # url: url
        }

        puts @data      

    

    def fetch
      uri = URI.parse("http://www.google.com/ig/api?stock=AAPL")
      response = Net::HTTP.get_response(uri)
      quote = Nokogiri::XML(response.body)
      last_price = quote.xpath("//last").attribute("data").value
      volume = quote.xpath("//volume").attribute("data").value
      percent_change = quote.xpath("//perc_change").attribute("data").value
      url = BASE_URL + quote.xpath("//symbol_lookup_url").attribute("data").value
      
        puts "hello, I ran"

        @data = {
          last_price: last_price,
          volume: volume,
          percent_change: percent_change,
          url: url
        }

        puts @data      
    end
  end
end


