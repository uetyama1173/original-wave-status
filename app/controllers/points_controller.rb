class PointsController < ApplicationController
  include PointsHelper
  
require 'net/https'
require 'json'

    
  def index
    uri = URI.parse("https://api.windy.com/api/point-forecast/v2")
    http = Net::HTTP.new(uri.host, uri.port)
    
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    request_params = {
    	lat: 37.446,
    	lon: 138.601,
    	model: "wavewatch",
    	parameters: ["waves", "windWaves", "swell1"],
    	levels: ["surface"],
    	key: "DFJv9NGCnFk56qNBcJQNMZQESR7YvXl8"
    }
    
    request = Net::HTTP::Post.new(uri.path)
    request["Content-Type"] = "application/json"
    request.body = request_params.to_json
    
    response = http.request(request)
    
    results = {}
    res_hash = JSON.parse(response.read_body);
    res_hash.each {|key, value|
    	unless key == "ts" || key == "units" || key == "warning"
    	  results[key] = value[0]
    	end
    }
    # return results
   @height = p results['waves_height-surface']
   @direction = p results["waves_direction-surface"]
   @period = p results["waves_period-surface"]
   @wwaveheight = p results["wwaves_height-surface"]
   @wwavedirection = p results["wwaves_direction-surface"]
   @wwaveperiod = p results["wwaves_period-surface"]
   @s1h = p results["swell1_height-surface"]
   @s1d = p results["swell1_direction-surface"]
   @s1p = p results["swell1_period-surface"]
   
    
  end
end

