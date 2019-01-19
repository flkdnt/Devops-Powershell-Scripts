<#
.Synopsis 
    This script finds diskspace on each server in an inputlist. -Dante Foulke, 2018

.Description
    This script takes an Input server list and creates a .csv with Disk Space of the specified drives, C, D, E, etc. (Drivetype=3, Local hard disk)

    Change the Variables below: 
    $computerfile = get-Content "FILEPATH\FILE.txt"  - Input Server List
    $outfile = "FILEPATH\FILE.csv"                   - Output File List

#>


$computerfile = get-Content "FILEPATH\FILE.txt"
$outfile = "FILEPATH\FILE.csv"

#Creates a new file
New-Item $outfile -Force

#For each Computer in input server List
foreach ( $computer in $computerfile) { 
get-WmiObject win32_logicaldisk -ComputerName $computer -Filter "Drivetype=3"  |  
Select-Object PSComputerName, DeviceID, @{Label="Free Space GB";Expression={$_.Freespace / 1gb -as [int] }}, @{Label="Size GB";Expression={$_.Size / 1gb -as [int] }}, VolumeName | 
Export-csv -NoTypeInformation -Append -Path $outfile    
} 
