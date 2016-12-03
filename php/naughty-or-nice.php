<?php
// Are you naughty or nice? Find out by texting in your name.
// (c) 2016 Tropo. Released under MIT License

$status = 'NICE'; // By default, you're nice

// No phone calls, just text messages
if ($currentCall->channel != 'TEXT') { reject(); }

// Assume the text includes just the name
$name = $currentCall->initialText;

// Santa is special.
if (stristr($name, 'santa')) {
    say('Santa Claus is always nice.');
    hangup();
}

// If you text the same name over and over again,
// I want you to get the same result. But I don't want to track
// results or have everyone who starts with C always get the same result.
// So hash the name, and grab the first non-digit character.
// If it's D, E, or F then you're naughty.
$val = substr(preg_replace('/\d/g', '', md5(strtolower($name))), 0, 1);
if (ord($val) > ord ('c'))  { $status = 'NAUGHTY'; }

// Respond, but take a moment between responses, to add some realisim.
say("Hello $name, I'm checking my list.");
wait(2500);
say('I\'m checking it twice.');
wait(3000);
say("I've found out that you are $status.");
?>