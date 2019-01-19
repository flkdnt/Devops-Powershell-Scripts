<#
.Synopsis
This script enables Powershell remoting on servers

-Dante Foulke, 2018

.Description
Run on a server Locally to enable Remoting. 
Also Enables Windows Remoting Service, Remote Registry Service and Remote Procedure Call Service

Change "YOURSERVER01,YOURSERVER02" to a specified list of trusted servers to receive powershell commands from.

#>

Set-ExecutionPolicy RemoteSigned -force
Enable-PSRemoting -force
Set-Item WSMan:\localhost\Client\TrustedHosts "YOURSERVER01,YOURSERVER02" -force

#Enable Windows Remoting Service
$service = "WinRM"
$result = (gwmi win32_service -filter "name='$service'").ChangeStartMode("Automatic")
$result = (gwmi win32_service -filter "name='$service'").startservice()
#Enable Remote Procedure Call Service
$service = "RpcSs"
$result = (gwmi win32_service -filter "name='$service'").ChangeStartMode("Automatic")
$result = (gwmi win32_service -filter "name='$service'").startservice()
#Enable Remote Registry Service
$service = "RemoteRegistry"
$result = (gwmi win32_service -filter "name='$service'").ChangeStartMode("Automatic")
$result = (gwmi win32_service -filter "name='$service'").startservice()