// --------------------------------------------
// Sample app to dial out
// See http://www.tropo.com for more info
// --------------------------------------------

answer()
print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+callFactory);
say("transfering to ");

var ncall = call("sip:user@10.6.99.35", "sip:user@10.6.99.35");
if(ncall.name == "answer")
{
ncall.value.prompt("call to sip:user@10.6.99.35", "", 10000);
ncall.value.prompt("This is a dial test for java script in Tropo", "", 10000);
}
ncall.hangup()
hang() 
