require 'quaff'

phone = Quaff::UDPSIPEndpoint.new("sip:uas@example.com", "rkd", "secret", 5060, "localhost")
call = phone.incoming_call

data = call.recv_request("INVITE")

if data["message"].header("Contact").nil? then
  raise "INVITE was missing a Contact header!"
end

call.send_response(100, "Trying")
call.send_response(180, "Ringing")
call.send_response(200, "OK")
data = call.recv_request("ACK")

if data["message"].header("X-Anticipated-Header").nil? then
  raise "ACK was missing an expected header!"
end

call.recv_request("BYE")
call.send_response(200, "OK")
call.end_call
