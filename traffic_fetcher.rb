require "net/http"
require "nokogiri"

module Traffic
	class MapQuestFetcher
		
		MQ_KEY = 'Fmjtd%7Cluua2d6t2u%2Cb5%3Do5-hr85g'
		BASE_URL = "http://www.mapquestapi.com/traffic/v1/"

		# Lat/Long Bounding Box for Baltimore 
		LAT1 = "39.503136" # upper left latitude
		LONG1 = "-76.887259" # upper left longitude
		LAT2 = "39.077998" # lower right latitude
		LONG2 = "-76.337942" # lower right longitude
		BOUNDING_BOX = [LAT1,LONG1,LAT2,LONG2].join(',')
		
		MQ_URL = "#{BASE_URL}incidents?key=#{MQ_KEY}&callback=handleIncidentsResponse&boundingBox=#{BOUNDING_BOX}&filters=incidents&inFormat=kvp&outFormat=xml"

		def initialize
			@uri = URI.parse(MQ_URL)
			@response = Net::HTTP.get_response(@uri)
			@traffic_data = Nokogiri::XML(@response.body)			
		end

		def get_incidents			
		  @traffic_data.xpath("//Incident").children
		end		
	end


	class BingFetcher
		
		BING_KEY = 'AmAZzRl0lPmqYJ3i_GW9oaItcaSHgQnphkE1xl6N-1P5gyg68KPWVqvmlJwnxcCN'
		BASE_URL = "http://dev.virtualearth.net/REST/V1/Traffic/Incidents"


		LAT1 = "39.077998" # lower left latitude
		LONG1 = "-76.887259" # upper left longitude
		LAT2 = "39.503136" # upper right latitude
		LONG2 = "-76.337942" # lower right longitude
		BOUNDING_BOX = [LAT1,LONG1,LAT2,LONG2].join(',')

		BING_URL = "#{BASE_URL}/#{BOUNDING_BOX}/true?&o=xml&key=#{BING_KEY}"

		def initialize
			@uri = URI.parse(BING_URL)
			@response = Net::HTTP.get_response(@uri)
			@traffic_data = Nokogiri::XML(@response.body)
		end

		def get_incidents			
		  incidents = @traffic_data.xpath("//Copyright")
		
		  incidents.each do |incident| 		  
		  	puts incident.name
		  	puts incident.text
		  end
		  return incidents

		end		
	end	

end

