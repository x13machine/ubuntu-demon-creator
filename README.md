# ubuntu-demon-creator
I made this script for other automated bash scripts and to fix some bugs in this script: https://gist.github.com/naholyr/4275302.

Example:

	curl https://raw.githubusercontent.com/x13machine/ubuntu-demon-creator/master/create-demon.sh | sudo name="web" username="web" command="/home/web/start.sh" bash

You can also add the description parameter for whatever reason.

## Parameters:
* name: Name of the demon.
* username: The user the demon will run as.
* command: The command to run the demon.
* description (optional): The description of the demon.
	
