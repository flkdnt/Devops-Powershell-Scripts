<#
.Synopsis
This script will search for Installed Software on a list of servers -Dante Foulke, 2018

.Description
This script will search for Installed Software with the below Variables:

$computerfile = get-content "FILEPATH\FILE.txt"  --Location of Server List
$outfile = "FILEPATH\FILE.csv"                   --Location of Output File
$filter = "Name='Trend Micro OfficeScan Agent'"  --Filter, See below


------------FILTER VARIABLE----------------
Common Items to Filter by:
    IdentifyingNumber
    Name 
    Vendor
    Version

The Filter Variable is a SQL Query! The Error Message is:

Get-WmiObject : Invalid query "select * from Win32_Product where Micro"

For Example, 

"Name like '%Micro%'" will return Everything with "Micro" in the name

"Name='Trend Micro OfficeScan Agent'" will return the Exact Trend Version, such as:

Name              : Trend Micro OfficeScan Agent
Vendor            : Trend Micro Inc.
Version           : X.X.X.X
Caption           : Trend Micro OfficeScan Agent



.Example
Example 1: Search on a single Server:

$filter = "QUERY"
Get-WmiObject Win32_Product -filter $filter | Select Description,InstallDate,InstallLocation,ProductID,RegCompany,RegOwner,Vendor,Version

#>

$computerfile = get-content "FILEPATH\FILE.txt" 
$outfile = "FILEPATH\FILE.csv"                   
$filter = "QUERY"

ForEach ($computer in $computerfile) {
    Get-WmiObject -ComputerName $computer Win32_Product -filter $filter | Select __SERVER,Description,InstallDate,InstallLocation,ProductID,RegCompany,RegOwner,Vendor,Version | Export-Csv -NoTypeInformation -Path $outfile -Append
}
