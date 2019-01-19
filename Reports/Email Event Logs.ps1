<#
.Synopsis
This program Gathers Event Logs For a specific Computer and sends them to a specified requester. -Dante Foulke, 2018

.Description
Change the Variables below to Run:

$timestamp = Get-Date -Format HHss-MM-dd-yyyy  - DO NOT CHANGE
$sender ="YOURUSERNAME@ORG.com"                  - email of the person running the program
$requestor="USERNAME@ORG.com"                    - email of the person or team you are emailing the eventlogs to
$logname = "LOG"                               - Logname is the standard Windows log you want to read "Application", "Security", "System" etc.
$starttime = "TIME"                            - starttime is the furthest back in time you want logfiles to read. Format of start-time: July 24 2018 12:00:00PM
$endtime = Get-Date                            - endtime is currently set to the timestamp, the moment the script starts. Change to a time to a desired date NEWER than starttime. Format of end-time: July 24 2018 12:00:00PM
$computer = "COMPUTER"                         - computer is the computers requested.
$outfile = "FILEPATH\$computer $timestamp.csv" - Outfile is a location on your local machine that you can store the eventlog for emailing.
$smtpserver = "SMTPSERVER"                     - ORG SMTP Server

#>

$timestamp = Get-Date -Format HHss-MM-dd-yyyy
$sender ="YOURUSERNAME@ORG.com"
$requestor="USERNAME@ORG.com"
$logname = "LOG"
$starttime = "TIME"
$endtime = Get-Date
$computer = "COMPUTER"
$outfile = "FILEPATH\$computer $timestamp.csv"
$smtpserver = "SMTPSERVER"

Get-WinEvent -ComputerName $computer -FilterHashTable @{ logname=$logname; StartTime=$starttime; EndTime=$endtime } | Export-CSV -Path $outfile 

Send-MailMessage -From $sender -To $requestor,$sender -Subject "Event Logs for $computer" -Body "Please see the attached Event Logs for $computer - Powershell Bot" -Attachments $outfile -SmtpServer $smtpserver