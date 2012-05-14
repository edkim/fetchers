require "net/http"
require "nokogiri"

class TrafficIncidents
  
  KEY = 'Fmjtd%7Cluua2d6t2u%2Cb5%3Do5-hr85g'
  #maps url containing Lat/Long coordinates for Baltimore 
  MAPS_URL = "http://www.mapquestapi.com/traffic/v1/incidents?key=#{KEY}&callback=handleIncidentsResponse&boundingBox=39.503136,-76.887259,39.077998,-76.337942&filters=incidents&inFormat=kvp&outFormat=xml"


  
  uri = URI.parse(MAPS_URL)
  response = Net::HTTP.get_response(uri)
  traffic_data = Nokogiri::XML(response.body)
  incidents = traffic_data.xpath("//severity").children.text  #bucket by severity
  puts incidents.length.to_s + " incidents"

       
  @data = {
    incidents: incidents
  }

  puts @data        
end



