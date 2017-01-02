# ubuntu-demon-creator
An automated way of creating services/demons for ubuntu 16.04

Example:

	curl https://raw.githubusercontent.com/x13machine/ubuntu-demon-creator/master/create-demon.sh | sudo name="web" username="web" command="/home/web/start.sh" bash

You can also add the description parameter for whatever reason.

Parameters:

	Name: Name of the demon.
	Username: The user the demon will run as.
	Command: The command to run the demon.
	description (optional): The description of demon.
	
