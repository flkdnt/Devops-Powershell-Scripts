# Powershell Snippets

Some snippets to get you started:


## Pull a computer name using a local variable

	$env:computername


## List all files with a specified file extension

	Get-ChildItem -Path *.txt -Recurse -Force


## List Members of Active Directory Group

	Get-ADGroupMember AD_GROUP_NAME


## Connect to VMWARE with VMWARE Power CLI Module

	Connect-VIServer -Server SERVERNAME -User 'USERNAME' -Password 'PASSWORD'


## Install DotNet 3.5...
...after copying sxs folder to FILEPATH location

	Install-WindowsFeature Net-Framework-Core -source FILEPATH


## Get Date for Timestamp
Change the formate of MM-dd-yyyy to any format supported by windows 

	$Timestamp = get-date -f MM-dd-yyyy


## Send an Email from a PowerShell script

	Send-MailMessage -From "SENDER_EMAIL_ADDRESS" -To "RECEIVER_EMAIL_ADDRESS" -Subject "SUBJECT" -Body "MESSAGE TO BE SENT IN THE BODY" -Attachments "FILEPATH\FILE" -SmtpServer "SMTPSERVER"


## Take a specific action against a list of servers 
Use a foreach loop!

Add a list of computernames in a seperate file("FILEPATH\FILE.txt"), Example: 

	Server01
	Server02
	Server03

And then point the loop of your PowerShell script to the File in order to run actions:

	$computerfile = get-content "FILEPATH\FILE.txt"

	ForEach ($computer in $computerfile){ <# This line is where $computer variable is declared.#>

	<# Action needed to be taken against a server. 
	Use $computer to change the computername. #>
	} 
	#DONT FORGET YOUR BRACKETS!

## Enable Powershell Remoting

	Set-ExecutionPolicy RemoteSigned -force
	Enable-PSRemoting -force
	Set-Item WSMan:\localhost\Client\TrustedHosts "TRUSTED SERVERS" -force

## Show Hidden Files, System Files and File Extentions

Make sure you Enable Windows Firewall and RDP Service Before Running!

	$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
	Set-ItemProperty $key Hidden 1
	Set-ItemProperty $key HideFileExt 0
	Set-ItemProperty $key ShowSuperHidden 1