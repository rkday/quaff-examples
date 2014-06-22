require 'quaff'

phone = Quaff::TCPSIPEndpoint.new("sip:uas@example.com", "rkd", "secret", 5060, "localhost")
call = phone.incoming_call

data = call.recv_request("INVITE")
call.send_response(100, "Trying")
call.send_response(180, "Ringing")
call.send_response(200, "OK")
call.recv_any_of(["ACK", "BYE"])
call.recv_any_of(["ACK", "BYE"])
call.send_response(200, "OK")
call.end_call
puts "Call was successful!"
