 <#
 .Synopsis
    This script lists the folder permissions for each folder recursively to a CSV file. -Dante Foulke, 2018

 .DESCRIPTION
    Edit the variables with the folder structure and output file.
    
    $folder = "FILEPATH"
    $outfile = "FILEPATH\FILE.csv"
 
 #>

$folder = "FILEPATH"
$outfile = "FILEPATH\FILE.csv"

Get-childitem $folder -recurse | where{$_.psiscontainer} |
Get-Acl | % {
    $path = $_.Path
    $_.Access | % {
        New-Object PSObject -Property @{
            Folder = $path.Replace("Microsoft.PowerShell.Core\FileSystem::","")
            Access = $_.FileSystemRights
            Control = $_.AccessControlType
            User = $_.IdentityReference
            Inheritance = $_.IsInherited
            }
        }
    } | select-object -Property User, Access, Folder | export-csv -NoTypeInformation $outfile -force