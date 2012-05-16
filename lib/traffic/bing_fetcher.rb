module Traffic
  class BingFetcher
    attr_reader :data, :response        
    TRAFFIC_URL_BASE = "http://dev.virtualearth.net/REST/V1/Traffic/Incidents/"
    GEOCODE_URL_BASE = "http://dev.virtualearth.net/REST/v1/Locations/"

    LAT1 = "39.077998" # lower left latitude
    LONG1 = "-76.887259" # upper left longitude
    LAT2 = "39.503136" # upper right latitude
    LONG2 = "-76.337942" # lower right longitude
    BOUNDING_BOX = [LAT1,LONG1,LAT2,LONG2].join(',')

    def initialize (api_key)            
      @url_suffix = "?key=#{api_key}"
    end

    def fetch (location, radius = DEFAULT_RADIUS)
      location.gsub!(' ', '%20')      
      uri = URI.parse("#{GEOCODE_URL_BASE}#{location}#{@url_suffix}")
      response = Net::HTTP.get_response(uri).body
      coordinates = parse_coordinates_from response
      get_incidents_for coordinates, radius
    end   

    def parse_coordinates_from (response)
      JSON.parse(response)["resourceSets"].first["resources"].first["point"]["coordinates"]
    end

    def get_incidents_for (coordinates, radius)
      lat_ul = coordinates[0] + radius
      long_ul = coordinates[1] - radius
      lat_lr = coordinates[0] - radius
      long_lr = coordinates[1] + radius
      bounding_box = [lat_lr, long_ul, lat_ul, long_lr].join(',')
      parse_traffic_data_for bounding_box
    end

    def parse_traffic_data_for (bounding_box)
      uri = URI.parse("#{TRAFFIC_URL_BASE}#{bounding_box}#{@url_suffix}")
      response = Net::HTTP.get_response(uri).body
      incidents = JSON.parse(response)["resourceSets"].first["resources"]     

      @data = {
        incident_count: incidents.size,
        incidents: incidents
      }
    end
  end 
end