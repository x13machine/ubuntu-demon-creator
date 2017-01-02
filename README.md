# ubuntu-demon-creator
An automated way of creating services/demons in ubuntu 16.04.
It's based off: https://gist.github.com/naholyr/4275302
I made this script for automated bash scripts and to fix some bugs. 

Example:

	curl https://raw.githubusercontent.com/x13machine/ubuntu-demon-creator/master/create-demon.sh | sudo name="web" username="web" command="/home/web/start.sh" bash

You can also add the description parameter for whatever reason.

## Parameters:
* name: Name of the demon.
* username: The user the demon will run as.
* command: The command to run the demon.
* description (optional): The description of the demon.
	
