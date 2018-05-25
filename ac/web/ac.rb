require "rubygems"
require "sinatra/base"
require "open-uri"

class Ac < Sinatra::Base

  get '/' do
    thermostat_on = File.read("../thermostat_on").chomp == "true"
    on_or_off = thermostat_on ? "on" : "off"
    max_temp = File.read("../max_temp").chomp
    min_temp = File.read("../min_temp").chomp
    current_temp = temperature

    erb :index, :locals => {:on_or_off => on_or_off, :max_temp => max_temp, :min_temp => min_temp, :current_temp => current_temp}
  end

  get '/on' do
    File.write("../thermostat_on", "true")
    redirect "/"
  end

  get '/off' do
    File.write("../thermostat_on", "false")
    open("http://192.168.0.12/off")
    redirect "/"
  end

  get '/temp' do
    temperature
  end
  
  def temperature
    file = File.open("/sys/bus/w1/devices/28-00043d6071ff/w1_slave")
    lines = file.read.split("\n")
    if lines[0].end_with? "YES"
      reading = lines[1].match(/t=(\d+)/)[1]
      celsius = reading.to_f / 1000
      fahrenheit = (celsius * 1.8) + 32
      fahrenheit.round(1).to_s
    else
      "thermometer broken"
    end
  end
end

