---
layout: default
title:  "Quick Post Names"

---
In our new AI world its still important to know what pieces to fit together, I thought I would show a quick snippet I made up for making new files for posts created here.

For general project plumbing I like using a command line runner call just.  It helps create a consistent, but malleable interface for every project.  The Just command line runner is a simpler version of make files, is well documented, mature and rediscover project specific automations through a simple to remember list command.

There are a few things that are really inconvenient about making these file by hand.  

* Jekyll's formating makes typing them physically slow
* Jekyll's Convention over configuration makes several layer of magic difficult to remember.  
  * Where the heck to they go? 
  * What is the date convention / ordering that prepends the file name? 

The command itself is pretty interesting


 ``` bash 
 read -p "Article Name:" name ; touch "_posts/$(date +%Y-%m-%d)-${name//[[:space:]]/-}.md" 


By using the read command we can reduce the parameters to the smallest logical piece of information, the title of the post

The second part of the command solves my original problems in the following way.  

* it makes a new file in the right place
* it fills in the correct date information in the correct places in the file name
* it will use the title and substitute the right characters to convert that into the proper file name.  

So the interesting take away bits

* How to ask for input for a quick one liner
* command output substitution
* regex substitution of varables.  

