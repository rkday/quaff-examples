require 'quaff'

phone = UDPSIPEndpoint.new(5061)
call = phone.new_call("1",
                      "sip:uac@example.com",
                      phone.new_connection('localhost', 5060),
                      "sip:uas@example.com")

call.send_request("INVITE")
call.recv_response("180")
call.recv_response("200")
call.send_request("ACK")
sleep 2
call.send_request("BYE")
call.recv_response("200")
puts "Successful call!"
call.end_call
