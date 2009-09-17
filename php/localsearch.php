<?php
$categories = 'Afghan, American, Asian, Barbeque(Barbeque, BBQ), Brazilian, Breakfast, Brunch, British, Buffets(Buffets, Buffet), Burgers(Burgers,Burger), Caribbean, Wings(Wings, Chicken Wings, Hot Wings, Buffalo Wings), Chinese, Creperies(Creperies, Crepes), Deli(Deli, Delis), Diners(Diners, Dinner, Greasy Spoon), Ethiopian, Fast Food, Filipino, French, German, Greek, Hawaiian, Hot Dogs(Hot Dogs, Sausages, Dogs), Indian, Italian, Japanese, Korean, Latin American, Mediterranean, Mexican, Middle Eastern, Mongolian, Moroccan, Pakistani, Persian(Iranian, Persian), Pizza, Russian, Sandwiches, Seafood, Soul Food(Soul Food, Soul), Southern, Steakhouses(Steakhouses, Steak, Steakhouse), Sushi(Sushi, Sushi Bar, Sushi Bars, Sashimi), Taiwanese, Tapas, Tex Mex, Thai, Vegan, Vegetarian, Vietnamese, Bagels, Bakeries(Bakery, Bakeries), Beer, Wine, Breweries(Breweries, Brewery), Coffee, Tea, Convenience Store, Desserts, Donuts, Farmers Market, Grocery, Ice Cream, Frozen Yogurt(Frozen Yogurt, Yogurt), Juice Bars, Smoothies(Smoothie, Smoothies), Specialty Food, Wineries(Wine, Wineries, Winery)';

answer(30);
sleep(2);
say('hello.');

$event = prompt('What zip code are you calling from?',
			array (
			  "choices" => '[5 DIGITS]',
			) 
		 );

if ($event->name == 'choice') {
  $zip = $event->value;
  $event = prompt('What are you looking for in '. str_replace(' ','-',chunk_split($zip,1)) .'?',
  			array (
  			  "choices" => $categories,
  			) 
  		 );
  if ($event->name == 'choice') {
    $category = $event->value;
    $url = 'http://local.yahooapis.com/LocalSearchService/V3/localSearch?appid=TropoDemo&query='. $category .'&zip='. $zip .'&results=5&output=php';
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    $output = unserialize(curl_exec($ch));
    curl_close($ch);
    $choices = '';
    $i = 1;
    foreach ($output['ResultSet']['Result'] as $result) {
      $title = str_replace(' & ', ' and ', $result['Title']);
      $choices .= 'press '. $i .' for '. $title .', ';
      $number[$i] = $result['Phone'];
      $name[$i] = $title;
      $i++;
    }
    $event = prompt($choices,
    			array (
    			  "choices" => '1,2,3,4,5',
    			) 
    		 );
    if ($event->name == 'choice') {
      say('Connecting you to '. $name[$event->value] .' at '. $number[$event->value] .'. Please hold.');
      transfer(preg_replace('[^0-9]','',$number[$event->value]));
    }
  }
}

hangup();
?>
