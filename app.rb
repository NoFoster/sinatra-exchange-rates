require "sinatra"
require "sinatra/reloader"
require "dotenv/load"
require "http"
require "json"


get("/") do

@raw_response = HTTP.get("https://api.exchangerate.host/list?access_key=#{ENV.fetch('EXCHANGE_RATE_KEY')}")
@raw_string = @raw_response.to_s
@parsed_response = JSON.parse(@raw_string)
@currency_hash = @parsed_response.fetch("currencies")

 @currency_list = @currency_hash.keys
  erb(:homepage)
end


get("/:primary") do
  @primary = params.fetch("primary")

  @raw_response = HTTP.get("https://api.exchangerate.host/list?access_key=#{ENV.fetch('EXCHANGE_RATE_KEY')}")
@raw_string = @raw_response.to_s
@parsed_response = JSON.parse(@raw_string)
@countries= @parsed_response.fetch("currencies")

  erb(:primary_list)
end


get("/:primary/:secondary") do
  @primary = params.fetch("primary")
  @secondary = params.fetch("secondary")

  
  @conv_raw_response = HTTP.get("https://api.exchangerate.host/convert?from=#{@primary}&to=#{@secondary}&amount=1&access_key=#{ENV.fetch('EXCHANGE_RATE_KEY')}")
  @conv_string_response= @conv_raw_response.to_s
  @con_parsed_response = JSON.parse(@conv_string_response)
  @conversion = @con_parsed_response.fetch("result")

  erb(:secondary)
end
