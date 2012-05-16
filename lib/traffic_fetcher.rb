require 'net/http'
require 'json'
require_relative '../lib/traffic/bing_fetcher.rb'
require_relative '../lib/traffic/mapquest_fetcher.rb'

module Traffic
  DEFAULT_RADIUS = 0.181 #Used to generate bounding box from single lat/long
end