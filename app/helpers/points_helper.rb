module PointsHelper
    require 'net/https'
require 'json'

  def get_data
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
   return results  
  end
end

