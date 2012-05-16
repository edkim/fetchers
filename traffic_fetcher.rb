require "net/http"
require "json"

module Traffic
  DEFAULT_RADIUS = 0.181 #Used to generate bounding box from single lat/long

  class MapQuestFetcher
    attr_reader :data
        
    MQ_TRAFFIC_OPTIONS = "&filters=incidents"

    def initialize (api_key)
      @traffic_url_base = "http://www.mapquestapi.com/traffic/v1/incidents?key=#{api_key}&inFormat=kvp"
      @geocode_url_base = "http://www.mapquestapi.com/geocoding/v1/address?key=#{api_key}&inFormat=kvp"
    end

    def fetch (location)
      location.gsub!(' ', '%20')
      uri = URI.parse("#{@geocode_url_base}&location=#{location}")
      response = Net::HTTP.get_response(uri).body
      coordinates = parse_coordinates_from response     
      get_incidents_for coordinates, DEFAULT_RADIUS
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
# fetcher = Traffic::BingFetcher.new('AmAZzRl0lPmqYJ3i_GW9oaItcaSHgQnphkE1xl6N-1P5gyg68KPWVqvmlJwnxcCN').get_incidents
end