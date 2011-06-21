## This module is intended to use Trulia api.

module Trulia

  class LocationInfo

## Passing the api key.    
    def initialize(api_key)
      @base_url = 'http://api.trulia.com/webservices.php'
      @params = {:library => 'LocationInfo', :apikey => api_key}
    end
    
    def get_cities_in_state(state)
      options = {:function => 'getCitiesInState', :state => state}
      response(options)
    end
    
    def get_counties_in_state(state)
      options = {:function => 'getCountiesInState', :state => state}
      response(options)
    end
    
    def get_neighborhoods_in_city(city, state)
      options = {:function => 'getNeighborhoodsInCity', :city => city, :state => state}
      response(options)
    end
    
    def get_states
      options = {:function => 'getStates'}
      response(options)
    end
    
    def get_zip_codes_in_state(state)
      options = {:function => 'getZipCodesInState', :state => state}
      response(options)
    end
    
    private
##Sending a request to using httparty gem. Response will be parsed by the response class     


    def response(options)
      Response.new(HTTParty.get(@base_url, :query => options.merge(@params)))
    end
  end

##Trulia stats class.
## This shows the  average listing price and available inventory for any city or neighborhood in the US for the past year.  
  class TruliaStats
   
    def initialize(api_key)
      @base_url = 'http://api.trulia.com/webservices.php'
      @params = {:library => 'TruliaStats', :apikey => api_key}
    end
    
    def get_city_stats(city, state, options_extended={})
      options = {:function => 'getCityStats', :city => city, :state => state}
      response(options)
    end
    
    def get_county_stats(county, state, options_extended={})
      options = {:function => 'getCountyStats', :county => county, :state => state}
      response(options)
    end
    
    def get_neighborhood_stats(neighborhood_id, options_extended={})
      options = {:function => 'getNeighborhoodStats', :neighborhoodId => neighborhood_id}
      response(options)
    end
    
    def get_state_stats(state, options_extended={})
      options = {:function => 'getStateStats', :state => state}
      response(options)
    end
    
    def get_zip_code_stats(zip_code, options_extended={})
      options = {:function => 'getZipCodeStats', :zipCode => zip_code}
      response(options)
    end
  
    private
    
    def response(options, options_extended={})
      options.merge!(options_extended) unless options_extended.blank?
      Response.new(HTTParty.get(@base_url, :query => options.merge(@params)))
    end
  end

##This class intends to process the response recieved
##It has method like 
##  result - retrun the resultant based on the request
##  error  - api based error handling  

  class Response
    attr_accessor :body
    
    def initialize(body)
      @body = body
    end
    
    def result
      if @body['TruliaWebServices']['response'].has_key?('LocationInfo')
        @body['TruliaWebServices']['response']['LocationInfo']
      else
        @body['TruliaWebServices']['response']['TruliaStats']
      end
    end
    
    def error
      if @body['TruliaWebServices']['response'].has_key?('LocationInfo')
        @body['TruliaWebServices']['response']['LocationInfo']['error']
      else
        @body['TruliaWebServices']['response']['TruliaStats']['error']
      end
    end

    
    def listing_stats
      @body['TruliaWebServices']['response']['TruliaStats']['listingStats']
    end
      
    def traffic_stats
      @body['TruliaWebServices']['response']['TruliaStats']['trafficStats']
    end
    
    def location
      @body['TruliaWebServices']['response']['TruliaStats']['location']
    end

  end
  
end

