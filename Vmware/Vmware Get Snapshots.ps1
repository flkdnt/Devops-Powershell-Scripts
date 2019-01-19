<#
.Synopsis
THIS SCRIPT REQUIRES VMWARE POWER CLI MODULE!

This script Lists Snapshots by servername. -Dante Foulke, 2018

.Description
This script runs for a list of fileservers and outputs to a csv.

Change the Variables to run the script:

$user = "USERNAME"                              - USERNAME of user running the script
$password = "PASSWORD"                          - Password of user running the script 
$computerfile = get-content "FILEPATH\FILE.txt" - Server List File
$outfile = "FILEPATH\FILE.csv"                  - Specified file output location

#>

$user = "USERNAME"
$password = "PASSWORD"
$computerfile = get-content "FILEPATH\FILE.txt"
$outfile = "FILEPATH\FILE.csv"
$VMwareServer = "SERVERNAME"

#Login to Vsphere server first
Connect-Viserver -Server $VMwareServer -User $user -Password $password

ForEach ($computer in $computerfile) {
Get-Snapshot -VM $computer | Select VM, Description, Created, SizeGB | Export-Csv -NoTypeInformation -Append -Path $outfile
}