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
  key = "38533390fa24b47db81e7ce551c63e98" # replace this with your real OpenWeather API key

  # construct the URL to get the API data (https://openweathermap.org/api/one-call-api)
#   url = "https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{long}&units=#{units}&appid=#{key}"
  url = "https://api.openweathermap.org/data/2.5/onecall?lat=42.0574063&lon=-87.6722787&units=imperial&appid=38533390fa24b47db81e7ce551c63e98"



  # make the call
  @forecast = HTTParty.get(url).parsed_response.to_hash
  @weather = "It is currently #{@forecast["current"]["temp"]} degrees and #{@forecast["current"]["weather"][0]["main"]}"
  @extended = []



# puts "It is currently #{@forecast["current"]["temp"]} degrees and #{@forecast["current"]["weather"][0]["main"]}"
puts "Extended forecast:"
for @day in @forecast["daily"]
    @extended << "A high of #{@day["temp"]["max"]} and #{@day["weather"][0]["main"]}"
end

puts @weather

### Get the news

url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=aec7fdb8c7634809aa7bc76a85331842"
@news = HTTParty.get(url).parsed_response.to_hash
# news is now a Hash you can pretty print (pp) and parse for your output

@title = []
@author = []
@website = []

# @deck << "#{rank}_of_#{suit}"

# puts "Headlines of the Day:"
for headline in @news["articles"]
#   puts "#{headline["title"]} by #{headline["author"]}"
  @title << "#{headline["title"]}"
  @author << "#{headline["author"]}"
  @website << "#{headline["url"]}"
end


puts @website[0]

view "news"

end