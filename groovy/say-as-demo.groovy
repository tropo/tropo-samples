// --------------------------------------------
// say-as templates
// demonstrates how to use <say-as> to change
// how the text is read out
// See http://www.tropo.com for more info
// --------------------------------------------

answer();
s_log_prefix = "Log: "
s_xml_speak_start ="<?xml version='1.0'?><speak>"
s_say_as_speak_end = "</say-as></speak>"
//
//  Currency:
s_currency_say_as = "<say-as interpret-as='vxml:currency'>"
s_currency_value = "USD158.77"
s_prompt = s_xml_speak_start + s_currency_say_as + s_currency_value + s_say_as_speak_end
log(s_log_prefix + s_prompt)
prompt("Listen to money amount")
prompt(s_prompt)
//
// Digits:
s_digits_say_as = "<say-as interpret-as='vxml:digits'>"
s_digits_value = "541123456"
s_prompt = s_xml_speak_start + s_digits_say_as + s_digits_value + s_say_as_speak_end
log(s_log_prefix + s_prompt)
prompt("Listen to a string of digits")
prompt(s_prompt)
//
//Number:
s_number_say_as = "<say-as interpret-as='vxml:number'>"
s_number_value = "541.123"
s_prompt = s_xml_speak_start + s_number_say_as + s_number_value + s_say_as_speak_end
log(s_log_prefix + s_prompt)
prompt("Listen to number")
prompt(s_prompt)
//
//Date:
s_date_say_as = "<say-as interpret-as='vxml:date'>"
s_date_value = "20020322"
s_prompt = s_xml_speak_start + s_date_say_as + s_date_value + s_say_as_speak_end
prompt("Listen to date")
log(s_log_prefix + s_prompt)
prompt(s_prompt)
s_date_value = "????1031"
s_prompt = s_xml_speak_start + s_date_say_as + s_date_value + s_say_as_speak_end
prompt("Listen to another date")
log(s_log_prefix + s_prompt)
prompt(s_prompt)
//
//time:
s_time_say_as = "<say-as interpret-as='vxml:time'>"
s_time_value = "0825p"
s_prompt = s_xml_speak_start + s_time_say_as + s_time_value + s_say_as_speak_end
prompt("Listen to time")
log(s_log_prefix + s_prompt)
prompt(s_prompt)
s_time_say_as = "<say-as interpret-as='vxml:time'>"
s_time_value = "1025a"
s_prompt = s_xml_speak_start + s_time_say_as + s_time_value + s_say_as_speak_end
prompt("Listen to another time")
log(s_log_prefix + s_prompt)
prompt(s_prompt)
//
//phone:
s_phone_say_as = "<say-as interpret-as='vxml:phone'>"
s_phone_value = "4074180000x4321"
s_prompt = s_xml_speak_start + s_phone_say_as + s_phone_value + s_say_as_speak_end
prompt("Listen to phone")
log(s_log_prefix + s_prompt)
prompt(s_prompt)
prompt("Good bye and have a nice day!")

hangup();
