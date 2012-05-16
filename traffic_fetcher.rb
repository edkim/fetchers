require "net/http"
require "nokogiri"
require "json"

module Traffic
	class MapQuestFetcher
		attr_reader :data, :response
		
		BASE_URL = "http://www.mapquestapi.com/traffic/v1/incidents"		

		# Lat/Long Bounding Box for Baltimore 
		LAT1 = "39.503136" # upper left latitude
		LONG1 = "-76.887259" # upper left longitude
		LAT2 = "39.077998" # lower right latitude
		LONG2 = "-76.337942" # lower right longitude
		BOUNDING_BOX = [LAT1,LONG1,LAT2,LONG2].join(',')
		
		def initialize (api_key)
			@uri = URI.parse("#{BASE_URL}?key=#{api_key}&boundingBox=#{BOUNDING_BOX}&filters=incidents&inFormat=kvp")
			@response = Net::HTTP.get_response(@uri)			
		end

		def get_incidents
		  incidents = JSON.parse(@response.body)["incidents"]

		  @data = {
		  	incident_count: incidents.size,
		  	incidents: incidents
		  }
		end		
	end


	class BingFetcher
		attr_reader :data, :response
		#BING_DUMMY_DATA = {"authenticationResultCode":"ValidCredentials","brandLogoUri":"http:\/\/dev.virtualearth.net\/Branding\/logo_powered_by.png","copyright":"Copyright Â© 2012 Microsoft and its suppliers. All rights reserved. This API cannot be accessed and the content and any results may not be used, reproduced or transmitted in any manner without express written permission from Microsoft Corporation.","resourceSets":[{"estimatedTotal":3,"resources":[{"__type":"TrafficIncident:http:\/\/schemas.microsoft.com\/search\/local\/ws\/rest\/v1","point":{"type":"Point","coordinates":[39.30538,-76.64331]},"congestion":"","description":"Presstman St at N Gilmor St - earlier is clear","detour":"","end":"\/Date(1337126400000)\/","incidentId":306858179,"lane":"","lastModified":"\/Date(1337125211163)\/","roadClosed":false,"severity":1,"start":"\/Date(1337123460000)\/","type":1,"verified":true},{"__type":"TrafficIncident:http:\/\/schemas.microsoft.com\/search\/local\/ws\/rest\/v1","point":{"type":"Point","coordinates":[39.31561,-76.6284]},"congestion":"","description":"in both directions at 28th St (#7) - emergency repair work","detour":"","end":"\/Date(1339077600000)\/","incidentId":303280134,"lane":"Left lane blocked","lastModified":"\/Date(1337068947707)\/","roadClosed":false,"severity":2,"start":"\/Date(1334358000000)\/","type":9,"verified":true},{"__type":"TrafficIncident:http:\/\/schemas.microsoft.com\/search\/local\/ws\/rest\/v1","point":{"type":"Point","coordinates":[39.35081,-76.75047]},"congestion":"","description":"WB RT-26|Liberty Rd between Washington Ave and Milford Mill Rd - water main break","detour":"","end":"\/Date(1337131800000)\/","incidentId":306852778,"lane":"only left lane gets by","lastModified":"\/Date(1337122812397)\/","roadClosed":false,"severity":3,"start":"\/Date(1337006400000)\/","type":8,"verified":true}]}],"statusCode":200,"statusDescription":"OK","traceId":"3c62cff40c6b4e059bde6fa065a592da|BL2M002302|02.00.127.1000|"}

		
		BASE_URL = "http://dev.virtualearth.net/REST/V1/Traffic/Incidents"


		LAT1 = "39.077998" # lower left latitude
		LONG1 = "-76.887259" # upper left longitude
		LAT2 = "39.503136" # upper right latitude
		LONG2 = "-76.337942" # lower right longitude
		BOUNDING_BOX = [LAT1,LONG1,LAT2,LONG2].join(',')

		def initialize (api_key)						
			@uri = URI.parse("#{BASE_URL}/#{BOUNDING_BOX}?key=#{api_key}")
			@response = Net::HTTP.get_response(@uri)
		end

		def get_incidents			
		  incidents = JSON.parse(@response.body)["resourceSets"].first["resources"]		  			 
		  
		  @data = {
   			incidents_count: incidents.size,
   			incidents: incidents
  		}  		
		end		
	end	
# fetcher = Traffic::BingFetcher.new('AmAZzRl0lPmqYJ3i_GW9oaItcaSHgQnphkE1xl6N-1P5gyg68KPWVqvmlJwnxcCN').get_incidents
end

