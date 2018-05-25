require 'sinatra'

class Control < Sinatra::Base
  get '/' do
    pin0 = `gpio read 0`
    pin1 = `gpio read 1`
    if pin0.to_i == 0 && pin1.to_i == 0
      "on"
    elsif pin0.to_i == 1 && pin1.to_i == 1
      "off"
    else
      "error"
    end
  end

  get '/on' do
    `gpio mode 0 output`
    `gpio mode 1 output`
    `gpio write 0 0`
    `gpio write 1 0`
  end


  get '/off' do
    `gpio mode 0 output`
    `gpio mode 1 output`
    `gpio write 0 1`
    `gpio write 1 1`
  end
end

