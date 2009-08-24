
function doSay(p){
log(LogPrefix + p.say_as_type);
prompt(p.say_as_type);
var speak_it = say_as_start+ p.say_as + p.say_as_value + say_as_end;
log(LogPrefix + speak_it);
prompt(speak_it);
}
 
answer();
var LogPrefix = "Log: ";
var say_as_end = "</say-as></speak>";
var say_as_start = "<?xml version='1.0'?><speak>";
var o_CURR = new Object();
o_CURR.say_as = "<say-as interpret-as='vxml:currency'>";
o_CURR.say_as_value = 'USD51.33';
o_CURR.say_as_type= 'currency';
doSay(o_CURR);
 
var o_DIGS = new Object();
o_DIGS.say_as = "<say-as interpret-as='vxml:digits'>";
o_DIGS.say_as_value = '20314253';
o_DIGS.say_as_type= 'digits';
doSay(o_DIGS);
 
var o_NUMB = new Object();
o_NUMB.say_as = "<say-as interpret-as='vxml:number'>";
o_NUMB.say_as_value = '2031.425';
o_NUMB.say_as_type= 'number';
doSay(o_NUMB);
 
var o_PHON = new Object();
o_PHON.say_as = "<say-as interpret-as='vxml:phone'>";
o_PHON.say_as_value = '40741800x4321';
o_PHON.say_as_type= 'phone';
doSay(o_PHON);
 
var o_DATE = new Object();
o_DATE.say_as = "<say-as interpret-as='vxml:date'>";
o_DATE.say_as_value = '20090226';
o_DATE.say_as_type= 'date';
doSay(o_DATE);
 
var o_TIME = new Object();
o_TIME.say_as = "<say-as interpret-as='vxml:time'>";
o_TIME.say_as_value = '0515a';
o_TIME.say_as_type= 'time';
doSay(o_TIME);
 
 
hangup();