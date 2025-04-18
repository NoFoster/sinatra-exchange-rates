require "sinatra"
require "sinatra/reloader"
require "dotenv/load"

ENV.fetch("EXCHANGE_RATE_KEY")

get("/") do

  erb(:homepage)
end

get("/:primary") do

  erb(:primary_list)
end

get("/:primary/:secondary") do

  erb(:secondary)
end
