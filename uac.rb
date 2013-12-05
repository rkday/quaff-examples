require 'quaff'

phone = Quaff::UDPSIPEndpoint.new("sip:uac@example.com", "rkd", "secret", 5062, "localhost", 5061)
call = phone.outgoing_call("sip:uas@example.com")

call.send_request("INVITE")
call.recv_response("180")
call.recv_response("200")
call.send_request("ACK")
sleep 2
call.send_request("BYE")
call.recv_response("200")
puts "Successful call!"
call.end_call
