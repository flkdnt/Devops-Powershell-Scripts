<#
.Synopsis
    Script to Output a list of Active Directory Group Members to a text File - Dante Foulke, 2018

.Description
    Change the Below Variables before running:

    $ADgroup = "ACTIVE DIRECTORY GROUP NAME"  - What Active Directory Group you listing Membership for
    $Domain = "DOMAIN"                        - Specific Domain
    $Outfile = "FILEPATH\FILE$timestamp.txt"  - Replace ONLY the FILEPATH\FILE

#>

$ADgroup = "ACTIVE DIRECTORY GROUP NAME"
$Domain = "DOMAIN"
$timestamp = Get-Date -Format FileDateTime
$Outfile = "FILEPATH\FILE$timestamp.txt"

Get-ADGroupMember $ADGroup -server $Domain | where-object –FilterScript {$_.objectClass –eq “user”} | get-aduser -property * | select-object  SamAccountName,Name | Out-File -Path $Outfile -force
