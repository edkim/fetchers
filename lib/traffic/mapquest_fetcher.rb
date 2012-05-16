module Traffic
  class MapQuestFetcher
    attr_reader :data
        
    MQ_TRAFFIC_OPTIONS = "&filters=incidents"

    def initialize (api_key)
      @traffic_url_base = "http://www.mapquestapi.com/traffic/v1/incidents?key=#{api_key}&inFormat=kvp"
      @geocode_url_base = "http://www.mapquestapi.com/geocoding/v1/address?key=#{api_key}&inFormat=kvp"
    end
 
    def fetch (location, radius = DEFAULT_RADIUS)
      location.gsub!(' ', '%20')
      uri = URI.parse("#{@geocode_url_base}&location=#{location}")
      response = Net::HTTP.get_response(uri).body
      coordinates = parse_coordinates_from response     
      get_incidents_for coordinates, radius
    end

    def parse_coordinates_from (response)
      JSON.parse(response)["results"].first["locations"].first["latLng"]      
    end

    
    def get_incidents_for (coordinates, radius)
      lat_ul = coordinates["lat"] + radius
      long_ul = coordinates["lng"] - radius
      lat_lr = coordinates["lat"] - radius
      long_lr = coordinates["lng"] + radius
      bounding_box = [lat_ul, long_ul, lat_lr, long_lr].join(',')
      parse_traffic_data_for bounding_box
    end   

    def parse_traffic_data_for (bounding_box)
      uri = URI.parse("#{@traffic_url_base}&boundingBox=#{bounding_box}#{MQ_TRAFFIC_OPTIONS}")
      response = Net::HTTP.get_response(uri).body
      incidents = JSON.parse(response)["incidents"]

      @data = {
        incident_count: incidents.size,
        incidents: incidents
      }
    end
  end
end