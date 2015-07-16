/*
 * Copyright (c) 2009 - 2015 Tropo, now part of Cisco
 * Released under the MIT license. See the file LICENSE
 * for the complete license
 */

/**
 * Showing with the Express framework http://expressjs.com/
 * Express must be installed for this sample to work
 */

require('../lib/tropo-webapi.js');
var express = require('express');
var app = express.createServer();

/**
 * Required to process the HTTP body
 * req.body has the Object while req.rawBody has the JSON string
 */

app.configure(function(){
	app.use(express.bodyDecoder());
});

app.post('/', function(req, res){
	// Create a new instance of the TropoWebAPI object.
	var tropo = new TropoWebAPI();
	if(req.body['session']['from']['channel'] == "TEXT") {
		tropo.say("This application is voice only.  Please call in using a regular phone, SIP phone or via Skype.");
		
		tropo.on("continue", null, null, true);
		
		res.send(TropoJSON(tropo));
	}
	
	// Use the say method https://www.tropo.com/docs/webapi/say.htm
	else {
	
	tropo.say("Welcome to my Tropo Web API node demo.");
	
	// Demonstrates how to use the base Tropo action classes.
	var say = new Say("Please ree cord your message after the beep.");
	var choices = new Choices(null, null, "#");

	// Action classes can be passed as parameters to TropoWebAPI class methods.
	// use the record method https://www.tropo.com/docs/webapi/record.htm
	tropo.record(3, false, null, choices, null, 5, 60, null, null, "recording", null, say, 5, null, "http://example.com/tropo", null, null);

	// use the on method https://www.tropo.com/docs/webapi/on.htm
	tropo.on("continue", null, "/answer", true);
	
	tropo.on("incomplete", null, "/timeout", true);
	
	tropo.on("error", null, "/error", true);

    res.send(TropoJSON(tropo));
}});

app.post('/answer', function(req, res){
	var tropo = new TropoWebAPI();
	tropo.say("Recording successfully saved.  Thank you!");

	res.send(TropoJSON(tropo));
});

app.post('/timeout', function(req, res){
	var tropo = new TropoWebAPI();
	tropo.say("Sorry, I didn't hear anything.  Please call back and try again.");

	res.send(TropoJSON(tropo));
});

app.post('/error', function(req, res){
	var tropo = new TropoWebAPI();
	tropo.say("Recording failed.  Please call back and try again.");

	res.send(TropoJSON(tropo));
});

app.listen(8000);
console.log('Server running on port :8000');
