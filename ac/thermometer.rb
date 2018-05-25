module Thermometer
  def self.read
    serial = ::THERMOMETER_SERIAL
    file = File.open("/sys/bus/w1/devices/#{serial}/w1_slave")
    lines = file.read.split("\n")
    raise ThermometerReadError unless lines[0].end_with? "YES"

    /t=(?<reading>\d+)/ =~ lines[1]
    celsius = reading.to_f / 1000
    celsius * 1.8 + 32
  end
end

class ThermometerReadError < StandardError
end
