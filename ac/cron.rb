#!/home/pi/.rvm/rubies/ruby-2.4.0/bin/ruby

require_relative "thermometer.rb"
require "open-uri"

::THERMOMETER_SERIAL = "28-00043d6071ff"

thermostat_on = File.read("thermostat_on").chomp

if thermostat_on == "true"
  max_temp = File.read("max_temp").chomp.to_f
  min_temp = File.read("min_temp").chomp.to_f

  temp = Thermometer.read
  time = Time.now.strftime("%F %R")

  puts "#{time} > #{temp}"

  if temp > max_temp
    puts ">> turning on"
    open("http://192.168.0.12/on")
  end

  if temp < min_temp
    puts ">> turning off"
    open("http://192.168.0.12/off")
  end
end

