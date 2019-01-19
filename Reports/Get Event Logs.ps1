<#
.Synopsis
This will get all eventlogs in Application After a specified Date/Time from a remote server -Dante Foulke, 2018

.Description
Change the variables below to run:

$log = "WINDOWSLOG"          - Change to Windows log to read from
$server="SERVERNAME"           - Change to Server to pull event logs from
$startdate="DATE START"      - Change date to requested start time: "April 01 2018 12:00:00AM"
$enddate ="DATE END"         - Change date to requested end time: "April 01 2018 1:00:00AM"
$outfile="FILEPATH\FILE.csv" - Change to requested Filepath

#>

$log = "WINDOWSLOG"
$server="SERVERNAME"
$startdate="DATE START"
$enddate ="DATE END"
$outfile="FILEPATH\FILE.csv"

Get-EventLog -LogName $log -ComputerName $server -After $startdate -Before $enddate | Export-CSV -NoTypeInformation $outfile
