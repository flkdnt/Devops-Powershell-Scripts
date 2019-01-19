<#
.Synopsis
This Script Requires Vmware PowerCLI to RUN!

This script exports Server Uptime to a CSV file. -Dante Foulke, 2018

.Description
This script exports Server Uptime to a CSV file.

Change the variables below in order to run:

$User = "USERNAME"                             - USERNAME of User running the Script
$Password = "PASSWORD"                      - Password of User running the Script
$stat = 'sys.osuptime.latest'               - DO NOT CHANGE
$entity = get-vm -location "VMWARE FOLDER"  - Change VMWARE FOLDER to to name of Vmware Folder
$outfile = "FILEPATH\FILE.csv"              - Change to Filepath where output file is to be placed.

#>

$User = "USERNAME"
$Password = "PASSWORD"
$stat = "sys.osuptime.latest"
$entity = get-vm -location "VMWARE FOLDER"
$outfile = "FILEPATH\FILE.csv"

Connect-VIserver -Server SERVERNAME -User $User -Password $Password

Get-Stat -Entity $entity -Stat $stat -Realtime -MaxSamples 1 -ErrorAction SilentlyContinue | Select @{N='VM';E={$_.Entity.Name}}, @{N='Uptime (d.hh:mm:ss)';E={[timespan]::FromSeconds($_.value)}} | Export-CSV -NoTypeInformation $outfile
