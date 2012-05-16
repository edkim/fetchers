module Traffic
  class BingFetcher
    attr_reader :data, :response        
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
        incident_count: incidents.size,
        incidents: incidents
      }     
    end   
  end 
end