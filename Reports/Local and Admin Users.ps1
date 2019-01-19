<#
.Synopsis
This script finds the members of the local Administrators group and Lists all local users. -Dante Foulke, 2018

.Description
This script finds the members of the local Administrators group and Lists all local users. It stores the files locally and emails(Optional) the reports.

Fill out the variables before you run the report:

$computerfile = get-content "FILEPATH\FILE.txt"   - Input File for  computernames
$adminfile = "FILEPATH\FILE.csv"                  - Output of Administrators Report
$usersfile = "FILEPATH\FILE.csv"                  - Output of Local Users Report
$from = "EMAIL@ORG.com"                          -  Who the email is From
$to = "EMAIL@ORG.com"                            -  Who the email is To
$smtpserver = "SMTP SERVER"                      -  SMTP Server
$messagebody = "EMAIL MESSAGE BODY"

#>

function GetLocalAdministrators([string]$computer=$env:computername){
      $group=[adsi]"WinNT://$computer/Administrators,group"
      $group.psbase.Invoke("Members") |
           ForEach-Object{
               $name=$_.GetType().InvokeMember("Name", 'GetProperty', $null, $_, $null)
               new-Object PSObject -property @{System=$computer;AccountName=$name;Group="Administrators"}
           }
           write-Host  "`r`n"
 }

function GetLocalUsers([string]$computer=$env:computername){
    ([ADSI]"WinNT://$computer").Children | ?{$_.SchemaClassName -eq 'user'} | %{
    $groups = $_.Groups() | %{$_.GetType().InvokeMember("Name", 'GetProperty', $null, $_, $null)}
    $_ | Select @{n='Server';e={$computer}},
    @{n='UserName';e={$_.Name}},
    @{n='Active';e={if($_.PasswordAge -like 0){$false} else{$true}}},
    @{n='PasswordExpired';e={if($_.PasswordExpired){$true} else{$false}}},
    @{n='PasswordAgeDays';e={[math]::Round($_.PasswordAge[0]/86400,0)}},
    @{n='LastLogin';e={$_.LastLogin}},
    @{n='Groups';e={$groups -join ';'}},
    @{n='Description';e={$_.Description}}
    }
}

$computerfile = get-content "FILEPATH\FILE.txt"
$adminfile = "FILEPATH\FILE.csv"
$usersfile = "FILEPATH\FILE.csv"
$from = "EMAIL@ORG.com"
$to = "EMAIL@ORG.com"
$smtpserver = "SMTP SERVER"
$subject = "EMAIL SUBJECT"
$messagebody = "EMAIL MESSAGE BODY"

ForEach ($computer in $computerfile) {
GetLocalAdministrators -computer $computer | Export-Csv -NoTypeInformation -Path $adminfile -Append
GetLocalUsers -computer $computer | Export-Csv -NoTypeInformation -Path $usersfile -Append
}

#Completely optional Step to Email Reports. 
Send-MailMessage -From $from -To $to -Subject $subject -Attachments $adminfile,$usersfile -Body $messagebody -SmtpServer $smtpserver
