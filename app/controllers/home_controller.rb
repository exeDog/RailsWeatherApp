require 'net/http'
require 'json'

class HomeController < ApplicationController
  def index
    url = 'http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=75024&distance=25&API_KEY=4C27472A-75A8-451F-B1D7-E31F5DFEF596'
    response = Net::HTTP.get(URI(url))
    @output = JSON.parse(response).empty? ? 'Error' : JSON.parse(response)[0]['AQI']
    change_background_color_and_description
    @output
  end

  private

  def change_background_color_and_description
    if @output != 'Error'
      if @output <= 50
        @background_color = 'green'
        @description = 'Air Quality Satisfactory'
      elsif @output.between?(51,100)
        @background_color = 'yellow'
        @description = 'Air Quality Acceptable'
      elsif @output.between?(101,150)
        @background_color = 'orange'
        @description = 'Air Quality Unhealthy'
      elsif @output.between?(151,200)
        @background_color = 'red'
        @description = 'Air Quality Bad'
      elsif @output.between?(201,300)
        @background_color = 'purple'
        @description = 'Air Quality Alert'
      elsif @output.between?(301,500)
        @background_color = 'maroon'
        @description = 'Air Quality Hazardous'
      end
    else
      @background_color = 'silver'
    end
  end
end

