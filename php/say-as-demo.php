<?php
/*
 * Copyright (c) 2009 - 2015 Tropo, now part of Cisco
 * Released under the MIT license. See the file LICENSE
 * for the complete license
 */

//
//  The application demonstrates how to use say-as constructions
//  for mostly-used variables, represented 
//  date, time, 
//  digits, numbers, 
//  currency, phone
//
//
answer();
$s_final_say = "Good bye and have a nice day!";
$s_log_prefix = "Log: ";
$s_xml_speak_start ="<?xml version='1.0'?><speak>";
$s_say_as_speak_end = "</say-as></speak>";
//
//
//  Currency:
$s_currency_say_as = "<say-as interpret-as='vxml:currency'>";
$s_currency_value = "USD158.77";
$s_prompt = $s_xml_speak_start .  $s_currency_say_as . $s_currency_value . $s_say_as_speak_end;
_log($s_log_prefix . $s_prompt);
say("Listen to money amount");
say($s_prompt);
//
//;
// Digits:;
$s_digits_say_as = "<say-as interpret-as='vxml:digits'>";
$s_digits_value = "541123456";
$s_prompt = $s_xml_speak_start . $s_digits_say_as . $s_digits_value . $s_say_as_speak_end;
_log($s_log_prefix . $s_prompt);
say("Listen to a string of digits");
say($s_prompt);
//;
//Number:;
$s_number_say_as = "<say-as interpret-as='vxml:number'>";
$s_number_value = "541.123";
$s_prompt = $s_xml_speak_start . $s_number_say_as . $s_number_value . $s_say_as_speak_end;
_log($s_log_prefix . $s_prompt);
say("Listen to number");
say($s_prompt);
//Date:;
$s_date_say_as = "<say-as interpret-as='vxml:date'>";
$s_date_value = "20020322";
$s_prompt = $s_xml_speak_start . $s_date_say_as . $s_date_value . $s_say_as_speak_end;
say("Listen to date");
_log($s_log_prefix . $s_prompt);
say($s_prompt);
$s_date_value = "????1031";
$s_prompt = $s_xml_speak_start . $s_date_say_as . $s_date_value . $s_say_as_speak_end;
say("Listen to another date");
_log($s_log_prefix . $s_prompt);
say($s_prompt);
//;
//time:;
$s_time_say_as = "<say-as interpret-as='vxml:time'>";
$s_time_value = "0825p";
$s_prompt = $s_xml_speak_start . $s_time_say_as . $s_time_value . $s_say_as_speak_end;
say("Listen to time");
_log($s_log_prefix . $s_prompt);
say($s_prompt);
$s_time_say_as = "<say-as interpret-as='vxml:time'>";
$s_time_value = "1025a";
$s_prompt = $s_xml_speak_start . $s_time_say_as . $s_time_value . $s_say_as_speak_end;
say("Listen to another time");
_log($s_log_prefix . $s_prompt);
say($s_prompt);
//;
//phone:;
$s_phone_say_as = "<say-as interpret-as='vxml:phone'>";
$s_phone_value = "4074180000x4321";
$s_prompt = $s_xml_speak_start . $s_phone_say_as . $s_phone_value . $s_say_as_speak_end;
say("Listen to phone");
_log($s_log_prefix . $s_prompt);
say($s_prompt);
//;
say($s_final_say);
hangup();
//
//
?>