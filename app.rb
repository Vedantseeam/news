require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
require 'news-api'
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "58c6427e2b29b06da70a7dabeffe76d1"

# Initialize News API
news-api = News.new("4f11a391ec2940a789cf7e40e66bef9a")     

get "/" do
  # show a view that asks for the location
    view "ask"
   

end

get "/news" do
  # do everything else

  puts "This is the related news"
    results = Geocoder.search(params["location"])
    @location = params["location"]
    lat_lng = results.first.coordinates
    @lat = lat_lng[0]
    @lng = lat_lng[1]
  
    forecast = ForecastIO.forecast(@lat,@lng).to_hash
    @temp = forecast["currently"]["temperature"]
    @summary = forecast["currently"]["summary"]

    f_array= forecast["daily"]["data"]
    for weather in f_array
        puts "A high temperature of #{weather["temperatureHigh"]} and #{weather["summary"]}"
    end 

     url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=1fb4347a5ae64c02bcd3747b6d05de77"
  @news = HTTParty.get(url).parsed_response.to_hash
  @newsarray = @news["articles"]
  @topheadlinearray = []
  @urlarray = []
  for articlenumber in @newsarray
    @topheadlinearray << articlenumber["title"]
    @urlarray << articlenumber["url"]
  end
end