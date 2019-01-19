<#
.Synopsis
This is a Template Script to Manage the same service on Remote Computers. -Dante Foulke, 2018

.Description
This script is a blank template to Enable/Disable and/or Stop/Start any number of windows services.
Change path in $computerfile to Server-list.

Change the below variables to run:

$service = "SERVICENAME" 						i.e., wuauserv is the name for the Windows Update Service
$computerfile = get-content "FILEPATH\FILE.txt"


.Example

Example 1: To run locally on a server:

$service = "SERVICENAME"

To Start a service:
$result = (gwmi win32_service -filter "name='$service'").startservice()

To Stop a service:
$result = (gwmi win32_service -filter "name='$service'").stopservice()

To Disable a service:
$result = (gwmi win32_service -filter "name='$service'").ChangeStartMode("Disabled")

To Enable a service:
$result = (gwmi win32_service -filter "name='$service'").ChangeStartMode("Automatic") 

#>

$service = "SERVICENAME"
$computerfile = get-content "FILEPATH\FILE.txt"

ForEach ($computer in $computerfile) {
#To Start a service:
$result = (gwmi win32_service -computername $computer -filter "name='$service'").startservice()

#To Stop a service:
$result = (gwmi win32_service -computername $computer -filter "name='$service'").stopservice()

#To Disable a service:
$result = (gwmi win32_service -computername $computer -filter "name='$service'").ChangeStartMode("Disabled")

#To Enable a service:
$result = (gwmi win32_service -computername $computer -filter "name='$service'").ChangeStartMode("Automatic")

}