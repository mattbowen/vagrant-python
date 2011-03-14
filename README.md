This is a *rough* set of configuration for vagrant to get Ubuntu Lucid setup with

* all the stuff you need for building PIL
* pythons 2.4, 2.5, 2.6, and 2.7 built in opt
* the system python 2.6 with PIL installed
 
The goal is to have a reasonable base for developing apps that require older pythons (e.g., google app engine, plone 3.x).

*Fair warning:* This version was put together a day after I read the vagrant docs. It's my first go at puppet, too. So, expect things to be badly tied together, not work on your system, etc. It's been tested on my OSX 10.6 laptop. I'll be working to improve it as I get more comfortable with puppet.

To get going:

* Install [virtual box](http://www.virtualbox.org/wiki/Downloads)
* Install [vagrant](http://vagrantup.com/) following the instructions on the homepage. If you're lucky like me, you'll need to upgrade ruby gems by doing sudo gem update --system
* clone this repo
* run "vagrant up" in the directory you cloned
* find something else to keep you busy for the next 30-45 minutes
* run "vagrant ssh" when the box is finished setting itself up

TODO:
* Test django apps
* Refactor puppet profile to be more general