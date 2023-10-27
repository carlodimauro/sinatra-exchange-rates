require "sinatra"
require "sinatra/reloader"
require "better_errors"
require "http"





get("/") do
  api_url = "https://api.exchangerate.host/list?access_key=" + ENV["EXCHANGE_RATE_KEY"].to_s
  raw_data = HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  parsed_data = JSON.parse(raw_data_string)
  @currencies = parsed_data.fetch("currencies")
  erb(:home)
end

get("/:starting_c") do
  api_url = "https://api.exchangerate.host/list?access_key=" + ENV["EXCHANGE_RATE_KEY"].to_s
  raw_data = HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  parsed_data = JSON.parse(raw_data_string)
  @currencies = parsed_data.fetch("currencies")

  @startc = params.fetch("starting_c")
  erb(:starting_currency)
end

get("/:starting_c/:end_c") do
  api_url = "https://api.exchangerate.host/list?access_key=" + ENV["EXCHANGE_RATE_KEY"].to_s
  raw_data = HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  parsed_data = JSON.parse(raw_data_string)
  @currencies = parsed_data.fetch("currencies")
  
  @startc = params.fetch("starting_c")
  @endc = params.fetch("end_c")
  convert_url = "https://api.exchangerate.host/convert?access_key=#{ENV["EXCHANGE_RATE_KEY"]}&from=#{@startc}&to=#{@endc}&amount=1"
  raw_convert_data = HTTP.get(convert_url)
  raw_conv_data_string = raw_convert_data.to_s
  parsed_conv_data = JSON.parse(raw_conv_data_string)
  @convresult = parsed_conv_data.fetch("result")
  erb(:result)
end
