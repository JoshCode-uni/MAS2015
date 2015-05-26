# Bugtracker #

## Carrier ##
##### <span style="color:orange;">[Critical]</span> - Always looks at the last location it saw a bot #####
Once the FlagCarrier has seen a bot, it won't ever reset it's look().

##### <span style="color:orange;">[Major]</span> - Roams the map after capture #####
If our flag is gone, the Carrier goes to our base and then goes all over the map

## Defender ##
##### <span style="color:red">[BLOCKING!]</span> - Doesn't handle goTo goals #####

It receives goTo goals but doesn't ever do something with it.

## Roamer ##