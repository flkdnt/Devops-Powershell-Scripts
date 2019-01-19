<#
.Synopsis
This script will get all events with a specific EventID from a list of servers -Dante Foulke, 2018

.Description
Outputs file of all instances of EventId on servers specified in a serverlist.


Change the variables below to run script: 

$computerfile = get-Content "FILEPATH\SERVERLIST.txt" - Input Computer File List
$outfile = "FILEPATH\FILE.csv"                        - .csv to output files to
$log= "WINDOWS LOG"                                   - Windows Log to search in "Security, Application, etc"   
$starttime= "STARTTIME"                               - End Time Format "July 04 2018 12:00:00AM"
$endtime= "ENDTIME"                                   - End Time, Format "July 04 2018 1:00:00AM"
$eventid="EVENT ID #"                                 - Event ID to search for


.Example
Example 1: To run for a single-server:

Get-WinEvent -FilterHashTable @{ logname='WINDOWS LOG'; StartTime="July 04 2018 12:00:00AM"; EndTime=""July 04 2018 1:00:00AM"; ID=4779 } | Export-csv -NoTypeInformation "FILEPATH\FILE.csv" -Force

#>

$computerfile = get-Content "FILEPATH\SERVERLIST.txt"
$outfile = "FILEPATH\FILE.csv"
$log= "WINDOWS LOG"
$starttime= "STARTTIME"
$endtime= "ENDTIME" 
$eventid="EVENT ID #"


ForEach ($computer in $computerfile) {
Get-WinEvent -ComputerName $computer -FilterHashTable @{ logname=$log; StartTime=$starttime;EndTime=$endtime; ID=$eventid } | Export-csv -NoTypeInformation $outfile -Append
}
