/*
 * Copyright (c) 2009 - 2015 Tropo, now part of Cisco
 * Released under the MIT license. See the file LICENSE
 * for the complete license
 */

// --------------------------------------------
// demonstrating transfer to a SIP URI
// --------------------------------------------

print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+callFactory);
say("transferring to ");

var ncall = currentCall.transfer("sip:81345209477@221.122.54.86", 30000);
print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+ncall);
log("Successfully transferred");
