require 'quaff'
require 'sdp'

phone = Quaff::UDPSIPEndpoint.new("sip:uac@example.com", "rkd", "secret", 5062, "localhost", 5061)
call = phone.outgoing_call("sip:uas@example.com")

call.send_request("INVITE", "some sdp", {"Content-Type" => "text/plain"})
call.recv_response("180")
ans = call.recv_response("200")
sdp = SDP.parse ans['message'].body
puts sdp.inspect
call.send_request("ACK")
sleep 2
call.send_request("BYE")
call.recv_response("200")
puts "Successful call!"
call.end_call
