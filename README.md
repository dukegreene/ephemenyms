# Ephemenyms

**What's in a name?**

**Are you sure?**

**Look again.**

### About Ephemenyms

This is a toy Twitter bot that takes a message/missive/manifesto, breaks it up into name-sized chunks, and auto-updates my Twitter name with a new chunk every minute until the whole string has been shared. 

After a few rounds of this, the name is reset to something I'd like to leave in place more permanently.

"Twitter name" doesn't refer to the "@" handle. It's the other one, which can reflect a real name ("Duke Greene"), a cause ("#BlackLivesMatter"), snark ("Swagny Taggart"), raw emotion ("¯\\_(ツ)_/¯")... anything, really. 

I wrote this to see how "anything" my anything could become.

I don't know how "useful" this is to anyone else, but I like imagining some lonely lurker refreshing their app at the right moment, noticing a change, chasing their curiosity with more refreshes, and becoming suddenly aware that there might be more ways to communicate on Twitter than the designers originally intended. 

Clunky, obtuse, pretentious ways, maybe. But more of them nonetheless.

Maybe you can find a better one!

### Do it Yourself!

You can use this code to try this experiment with your own strings/screeds/singalongs, and all you need is a Twitter account and Ruby installed on your machine.

Ok, that sentence isn't really fair. There are some steps to follow. But I haven't even refactored the spaghetti I've written so far, so I'll come back to clarify these instructions once I've made the code itself a little more readable and maintainable.

For now, know that the hardest parts are making sure Ruby is installed on your machine, creating a developer account at [Twitter's app portal](https://apps.twitter.com), and setting up a thing called git (kinda like GitHub, but kinda not) on your computer.

Google stuff like  
"find current Ruby version on ((Mac/PC/Ubuntu/Gam-Gam's priceless broach))",  
and "install Ruby tutorial for ((Mac/PC/Ubuntu/Gam-Gam's priceless broach))",  
and "generate Twitter API keys",  
and "install git" [(hey, a freebie!)](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
and "how to just quit reading all this overwhelming nonsense right this second and just go Google the first thing on the list that scares me, before my brain fills up with expectations and I talk myself out of the whole task due to panic". 

Especially that one. If you find a meaningful result, please email it to me at dukegreene@gmail.com. I fall into that trap all the time, and I'm always on the prowl for a better way out.

If you have Ruby installed and a crispy new set of Twitter API keys ready to rock, here's what you can do.

First, clone this repo.

In your command line (Eep! What the hell is a command line? And what is "cloning a repo"? I bet Google knows!), run:  
`gem install simple-oauth`  

Then create a new file called "keys.yml" and... ok, yeesh. There's a whole lot more to this. Pedagogy is harrrrrrrd. I swear I'll clean this up somehow. And it'll be magical for all of us. Or at least less unmagical than it is now.

You know what would be REALLY magical, though? If you figured out, from context clues alone, how to set up that file with the appropriate  
KEYS_AND: "values0123834xyz"  
ON_EACH: "lineinthefile39425663743abc"  
BASED_ON: "yourTwitterAPIkeys"  

...and then "cd" (that's a command line temr to look up) into your ephemenyms folder and run the code from the command line with  
`ruby ephemenym.rb`  

...and see what happens next!
