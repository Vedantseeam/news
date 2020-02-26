require "sinatra"
require "sinatra/reloader"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }  

get "/" do
  # lat: ± 90.0
  # long: ± 180.0
  @lat = rand(-90.0..90.0)
  @long = rand(-180.0..180.0)
  @lat_long = "#{@lat},#{@long}"
  view "where2"
end