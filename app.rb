require "sinatra"
require "sinatra/reloader"
require "dotenv/load"
require "http"
require "json"

er_key = ENV.fetch("EXCHANGE_RATE_KEY")

exchange_rate_url = "https://api.exchangerate.host/list?access_key=" + er_key
raw_response = HTTP.get(exchange_rate_url)
parsed_response = JSON.parse(raw_response)
currency_hash = parsed_response.fetch("currencies")

get("/") do

 @currency_list = currency_hash.keys.sort
  erb(:homepage)
end


get("/:primary") do
  @primary = params.fetch("primary")
  @countries = currency_hash.keys.sort
  erb(:primary_list)
end


get("/:primary/:secondary") do
  @primary = params.fetch("primary")
  @secondary = params.fetch("secondary")

  conversion_rate_url = "https://api.exchangerate.host/convert?from=#{@primary}&to=#{@secondary}&amount=1&access_key=" + er_key
conv_raw_response = HTTP.get(conversion_rate_url)
con_parsed_response = JSON.parse(conv_raw_response)
@conversion = con_parsed_response.fetch("result")

  erb(:secondary)
end
