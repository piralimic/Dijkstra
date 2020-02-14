require 'algo'

class CountriesController < ApplicationController

  def index
    @countries = Country.all
  end

  def show
    @country = Country.find(params[:id])
  end

  def result
    @country = Country.find(params[:country_id])
    @cities = @country.cities
    @ways = @country.from_ways

    @start_city_name = @cities.find(params[:city_from]).name
    @end_city_name = @cities.find(params[:city_to]).name

    @gr = Graph.new
    @ways.each do |w|
      @gr.add_edge(@cities.find(w.city_from_id).name, @cities.find(w.city_to_id).name, w.distance)
    end
    
    @msg = @gr.shortest_paths(@start_city_name, @end_city_name)
  end

end
