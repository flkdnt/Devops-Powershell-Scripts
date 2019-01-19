<#
.Synopsis
This script will get all events with a specific EventID from a list of servers. -Dante Foulke, 2018

.Description
Outputs file of all instances of EventId on servers specified in a serverlist.


Change the variables below to run script: 

$computerfile = get-Content "FILEPATH\SERVERLIST.txt" - Input Computer File List
$outfile = "FILEPATH\FILE.csv"                        - .csv to output files to
$starttime= "STARTTIME"                               - End Time Format "July 24 2018 12:00:00AM"
$endtime= "ENDTIME"                                   - End Time, Format "July 24 2018 1:00:00AM"
$keyword="*KEYWORD*"                                  - Keyword to search for, include *'s at the beginning and end of the keyword


.Example
Example 1: To run for a single-server:

Get-WinEvent -FilterHashTable @{ logname='WINDOWS LOG'; StartTime="July 24 2018 12:00:00AM"; EndTime=""July 24 2018 1:00:00AM"} | where-object  { $_.Message -like '*KEYWORD*' } | Export-csv -NoTypeInformation "FILEPATH\FILE.csv" -Force

#>


$computerfile = get-Content "FILEPATH\SERVERLIST.txt"
$outfile = "FILEPATH\FILE.csv" 
$starttime= "STARTTIME"
$endtime= "ENDTIME" 
$keyword="*KEYWORD*" 


ForEach ($computer in $computerfile) {
Get-WinEvent -ComputerName $computer -FilterHashtable @{logname='Application';StartTime=$starttime;EndTime=$endtime} | where-object  { $_.Message -like $keyword  }| Export-csv -NoTypeInformation $outfile -Append
Get-WinEvent -ComputerName $computer -FilterHashtable @{logname='Security';StartTime=$starttime;EndTime=$endtime} | where-object  { $_.Message -like $keyword  }| Export-csv -NoTypeInformation $outfile -Append
Get-WinEvent -ComputerName $computer -FilterHashtable @{logname='System';StartTime=$starttime;EndTime=$endtime} | where-object  { $_.Message -like $keyword } | Export-csv -NoTypeInformation $outfile -Append
}

