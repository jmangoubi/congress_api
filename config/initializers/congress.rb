
#Set the Api key for http://services.sunlightlabs.com/
#using the gems: congress, sunlight, transparencydata
###############################################
#Set your API Key for Sunlight Labs
my_api_key = "c82fc94befde45f1b4b1321412c710ac"

Congress.key = my_api_key
Sunlight::Base.api_key = my_api_key

TransparencyData.configure do |config|
 config.api_key = my_api_key
end

###############################################


