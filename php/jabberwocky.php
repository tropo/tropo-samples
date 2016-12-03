<?php
/*
 * Copyright (c) 2009 - 2015 Tropo, now part of Cisco
 * Released under the MIT license. See the file LICENSE
 * for the complete license
 */

// A demo of using SSML to influence pronounciation 
// and pacing of Lewis Carroll's famous poem full of
// nonsense words.

say("<speak>Welcome to Lewis Carroll's <phoneme alphabet='ipa' ph='dʒæbərwɔki'>Jabberwock</phoneme></speak>.", array('voice' => 'Vanessa'));
say("Here is the poem with detailed speech control.", array('voice' => 'Vanessa'));
say("<speak><p><s><phoneme alphabet='ipa' ph='twʌz'>Twas</phoneme> <phoneme alphabet='ipa' ph='brɪlɪg'>brillig</phoneme>, and the <phoneme alphabet='ipa' ph='slaɪði'>slithy</phoneme> toves Did <phoneme alphabet='ipa' ph='dʒaɪjʊər'>gyre</phoneme> and <phoneme alphabet='ipa' ph='dʒɪmbəl'>gimble</phoneme> in the wabe:</s> <s>All mimsy were the <phoneme alphabet='ipa' ph='boʊroʊgoʊvz'>borogoves</phoneme>,   And the mome raths <phoneme alphabet='ipa' ph='aʊtgreɪb'>outgrabe</phoneme>.</s></p>  <p><s>Beware the <phoneme alphabet='ipa' ph='dʒæbərwɔk'>Jabberwock</phoneme>, my son! The jaws that bite, the claws that catch!</s> <s>Beware the <phoneme alphabet='ipa' ph='dʒub dʒub'>Jubjub</phoneme> bird, and shun The frumious Bandersnatch!</s></p>  <p><s>He took his <phoneme alphabet='ipa' ph='ˈvɔrpʊl'>vorpal</phoneme> sword in hand:   Long time the manxome foe he sought -- So rested he by the Tumtum tree,   And stood awhile in thought.</s></p>  <p><s>And, as in uffish thought he stood,   The <phoneme alphabet='ipa' ph='dʒæbərwɔk'>Jabberwock</phoneme>, with eyes of flame, Came whiffling through the tulgey wood,   And burbled as it came!</s></p>  <p><s><prosody duration='1s'>One, two! One, two!</prosody> And through and through The <phoneme alphabet='ipa' ph='ˈvɔrpʊl'>vorpal</phoneme> blade went snicker-snack!</s> <s>He left it dead, and with its head   He went galumphing back.</s></p>  <p><s>And, has thou slain the <phoneme alphabet='ipa' ph='dʒæbərwɔk'>Jabberwock</phoneme>?</s> <s>Come to my arms, my <phoneme alphabet='ipa' ph='bimɪʃ'>beamish</phoneme> boy!</s> <s>O <phoneme alphabet='ipa' ph='fræbdʒɛs'>frabjous</phoneme> day! <emphasis level='strong'><phoneme alphabet='ipa' ph='kæˈlu'>Callooh</phoneme>! <phoneme alphabet='ipa' ph='ˈkæleɪ'>Callay</phoneme>!</emphasis> He chortled in his joy.</s></p> <p><s><phoneme alphabet='ipa' ph='twʌz'>Twas</phoneme> <phoneme alphabet='ipa' ph='brɪlɪg'>brillig</phoneme>, and the <phoneme alphabet='ipa' ph='slaɪði'>slithy</phoneme> toves Did <phoneme alphabet='ipa' ph='dʒaɪjʊər'>gyre</phoneme> and <phoneme alphabet='ipa' ph='dʒɪmbəl'>gimble</phoneme> in the wabe:</s> <s>All mimsy were the <phoneme alphabet='ipa' ph='boʊroʊgoʊvz'>borogoves</phoneme>,   And the mome raths <phoneme alphabet='ipa' ph='aʊtgreɪb'>outgrabe</phoneme>.</s></p></speak>", array('voice' => 'Victor'));

wait(2000);

say("And now, just the same text without any attempt to control output.", array('voice' => 'Vanessa'));
say("Twas brillig, and the slithy toves   Did gyre and gimble in the wabe: All mimsy were the borogoves,   And the mome raths outgrabe.   Beware the Jabberwock, my son!   The jaws that bite, the claws that catch! Beware the Jubjub bird, and shun   The frumious Bandersnatch!  He took his vorpal sword in hand:   Long time the manxome foe he sought -- So rested he by the Tumtum tree,   And stood awhile in thought.  And, as in uffish thought he stood,   The Jabberwock, with eyes of flame, Came whiffling through the tulgey wood,   And burbled as it came!  One, two! One, two! And through and through   The vorpal blade went snicker-snack! He left it dead, and with its head   He went galumphing back.  And, has thou slain the Jabberwock?   Come to my arms, my beamish boy! O frabjous day! Callooh! Callay!   He chortled in his joy.   Twas brillig, and the slithy toves   Did gyre and gimble in the wabe; All mimsy were the borogoves,   And the mome raths outgrabe.", array('voice' => 'Victor'));

wait(2000);
say('thanks! Goodbye.', array('voice' => 'Vanessa'));
?>