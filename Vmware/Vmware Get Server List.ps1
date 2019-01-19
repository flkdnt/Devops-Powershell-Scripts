<#
.Synopsis
THIS SCRIPT REQUIRES VMWARE POWER CLI!

This Command pulls a list of Servers from Vsphere. -Dante Foulke, 2018

.Description
THIS WILL PULL ALL SERVERS FROM ALL SIMILARLY NAMED FOLDERS ACROSS VSPHERE, SO MAKE SURE YOU SEARCH BY UNIQUE VSPHERE FOLDER NAMES!

This script creates a list of servers by Servername, IP, GB Memory, and Number of CPU's.

Change the Variables to run the script:

$user = "USERNAME"              - USERNAME of user running the script
$password = "PASSWORD"          - Password of user running the script 
$folder = "VMWARE FOLDER"       - VMware folder to list VM's from. For best Results, must be Uniquely across Vsphere
$outfile = "FILEPATH\FILE.csv"  - Specified file output location

#>

$user = "USERNAME"
$password = "PASSWORD"
$folder = "VMWARE FOLDER"
$outfile = "FILEPATH\FILE.csv"


Connect-VIserver -Server us1-pvctr01.corp.ORG.com -User $user -Password $password
get-vm -location $folder | Select Name, @{N="IP Address";E={@($_.guest.IPAddress -join '|')}}, MemoryGB, NumCpu | export-csv -NoTypeInformation -Force -$outfile

