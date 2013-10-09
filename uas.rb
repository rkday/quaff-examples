require 'quaff'

phone = Quaff::UDPSIPEndpoint.new(5060)
call = phone.new_call  # Without an argument, this gets the next incoming call

data = call.recv_request("INVITE")
call.send_response(100, "Trying")
call.send_response(180, "Ringing")
call.send_response(200, "OK")
call.recv_request("ACK")
call.recv_request("BYE")
call.send_response(200, "OK")
call.end_call
puts "Call was successful!"
