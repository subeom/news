require "sinatra"
require "sinatra/reloader"
require "httparty"
def view(template); erb template.to_sym; end

get "/" do
  ### Get the weather
  # Evanston, Kellogg Global Hub... replace with a different location if you want
  lat = 42.0574063
  long = -87.6722787

  units = "imperial" # or metric, whatever you like
  key = "fbbdcc7836d2e462e02352de98115561" # replace this with your real OpenWeather API key

  # construct the URL to get the API data (https://openweathermap.org/api/one-call-api)
  url = "https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{long}&units=#{units}&appid=#{key}"

  # make the call
  @forecast = HTTParty.get(url).parsed_response.to_hash

  ### Get the news
  url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=f8d277f8f5b64b36acfece6abe3a153e"
  @news = HTTParty.get(url).parsed_response.to_hash
  # news is now a Hash you can pretty print (pp) and parse for your output

  view "news"
end
