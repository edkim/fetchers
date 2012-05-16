Traffic Fetcher
=====

This program uses the MapQuest and Bing Maps APIs to collect data about traffic incidents

##Example Usage

@bing_fetcher = Traffic::BingFetcher.new(api_key)
@bing_fetcher.fetch("Washington, DC") # returns hash of traffic incident data around D.C.

##To Do:
* Increase accuracy of bounding box around a coordinate
* Incidents along a path
* Estimated driving time between points
* Error Handling e.g. when location can't be matched
* Change optional radius '''fetch parameter to be in miles (currently lat/long degrees)
* DRY up code (several similar methods exist for Map)



##Questions:

1) Moved API key out of the main app, but its still in tests. Is that ok?

##Assumptions (from wiki.answers.com)

1° of latitude = about 69.11 miles 

1° of longitude = about 69.11 miles along the equator. But all of the longitudes 
come together at the poles, so the farther you are from the equator, the fewer 
miles there are in one degree. 

Number of miles in 1° of longitude = (69.11) x (cosine of the latitude)

Read more: http://wiki.answers.com/Q/How_many_miles_are_in_a_degree_of_longitude_or_latitude#ixzz1v1b8yUVB
