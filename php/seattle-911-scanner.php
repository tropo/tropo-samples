<?php
answer();
sleep(2);
say ('Welcome to the Seattle <say-as interpret-as="vxml:digit">911</say-as> scanner.');
$timer = time();

$data = fetchIncidents();
if (count($data) == 0) {
  say("http://hosting.tropo.com/37423/www/audio/beep-7.mp3");
} 
while(1) {
  $data = fetchIncidents();
  foreach ($data as $incident) {
    say("<speak><paragraph xml:lang='en-us-fmj'>At <say-as interpret-as='address'>{$incident[8]}</say-as> an {$incident[9]}.</paragraph></speak>");
    $timer = time();
  }
  $currTime = time();
  if ($currTime - $timer > 30) {
    say("http://hosting.tropo.com/37423/www/audio/beep-7.mp3");
  }
  sleep(900);
}

function fetchIncidents() {
  $url = "http://data.seattle.gov/api/views/INLINE/rows.json?method=index";

  $time = time() - 360000;

  $data = '{"name":"Seattle Real Time Fire 911 Calls","query":{"orderBys":[{"expression":{"columnId":2354168,"type":"column"},"ascending":false}],"filterCondition":{"value":"AND","children":[{"children":[{"columnId":2354168,"type":"column"},{"value":' . $time . ',"type":"literal"}],"value":"GREATER_THAN","type":"operator"}],"type":"operator"}},"originalViewId":"kzjm-xkqj"}';

  $ch = curl_init($url);
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
  curl_setopt($ch, CURLOPT_AUTOREFERER, 1);
  curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
  curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
  curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-type: application/json'));
  curl_setopt($ch, CURLOPT_POSTFIELDS, $data);

  $json = curl_exec ($ch);

  curl_close($ch);

  $data = json_decode($json, true);
  return $data['data'];
}
?>