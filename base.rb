# Note that Fetchers::Stock inherits from a class called Fetchers::Base which provides some common behavior
# for all fetchers. That class is below for your reference. 

# For your first whack at this I recommend starting in a more simple way. Just use Ruby's built-in Net::HTTP
# library (instead of typhoeus) to fetch the results from Bing. You will need to use nokogiri or Ruby 1.9's 
# built-in JSON parser to convert the results of your query into something Ruby can process.

require 'net/http'

class Base
  attr_reader :data, :message

  def initialize(cue)
    @cue = cue
    puts "initializing"
    @success = false
    @message = ""
  end

  def success?
    @success
  end

  private

  def http_request(url,options = {})

    uri = URI('http://example.com/index.html?count=10')
    Net::HTTP.get(uri)

    # hydra = Typhoeus::Hydra.new
    # request = Typhoeus::Request.new(url,options)

    # request.on_complete do |response|
    #   if response.success?
    #     @success = true
    #     @message = "Request succeeded"
    #     yield response.body
    #   elsif response.timed_out?
    #     @message = "Request timed out for #{url}"
    #   elsif response.code == 0
    #     @message = response.curl_error_message
    #   else
    #     @message = "HTTP request failed for #{url}: " + response.code.to_s
    #   end
    # end

    # hydra.queue(request)
    # hydra.run

    
  end
end