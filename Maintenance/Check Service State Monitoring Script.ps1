<#
.Synopsis
This script check to see if Specified Services are running. -Dante Foulke, 2018

.Description
In the event that Services stop, this scripts attempts to start them. It sends an email to a requestor with a Warning if Successful, and Error on Failure. 
Also, Logging is "ERROR-ONLY", and the counter tracks if there are any errors and sends a closing email to prompt the receiver to check the Error log 

To Modify, Change the Following Variables:

    $status = "Running"                             --Desired service state(Running,Stopped) 
    $starttime = Get-Date -Hour 1                   --Time to Start Monitoring
    $endtime = Get-Date -Hour 23                    --Time to Stop Monitoring
    $svc1="Name='SERVICENAME'"                      --Service Name to Monitor
    $polltime = 30                                  --Number of Seconds to wait before the script loops again
    $outfile = "LOGFILE LOCATION"                   --Server Logfile Location
    $sender = "SENDER EMAIL"                        --Email "Sender" Account
    $receiver = "RECEIVER EMAIL"                    --Receiver of Email Alerts
    $emailserver = "EMAILSERVER"                    --SMTP Server

#>

$status = "Running"
$timestamp = Get-Date 
$filetimestamp = get-date -Format MM-dd-yyyy
$starttime = Get-Date -Hour 5
$endtime = Get-Date -Hour 19
$svc1="Name='SERVICENAME'"
$polltime = 30
$outfile = "LOGFILE LOCATION"
$sender = "SENDER EMAIL"
$receiver = "RECEIVER EMAIL"
$emailserver = "EMAILSERVER"
$counter = 0


Write-Output "$timestamp : Services Monitoring Starting for $timestamp" | Out-File -Append $outfile
Send-MailMessage -From $sender -To $receiver -Subject "$env:COMPUTERNAME SERVICES MONITORING STARTING" -Body "Services Monitoring has Started for $filetimestamp on $env:COMPUTERNAME. - Powershell Bot" -SmtpServer $emailserver

$result = (gwmi win32_service -filter $svc1).stopservice()
start-sleep -Seconds 10
$result = (gwmi win32_service -filter $svc1).startservice()
start-sleep -Seconds 5


While(($timestamp -gt $starttime) -and ($timestamp -lt $endtime)){

    $firstsvc = Get-WmiObject Win32_Service -filter $svc1 | Select State | ForEach-Object {$_.State}
    
    if($firstsvc -ne $status){
        $counter++
        $result = (gwmi win32_service -filter $svc1).stopservice()
        $result = (gwmi win32_service -filter $svc1).startservice()
        start-sleep -Seconds 15
        $firstsvc = Get-WmiObject Win32_Service -filter $svc1 | Select State | ForEach-Object {$_.State}
            if($firstsvc -ne $status){
            Send-MailMessage -From $sender -To $receiver -Subject "$env:COMPUTERNAME SERVICE ERROR" -Body "Service Has Failed on $env:COMPUTERNAME! - Powershell Bot" -SmtpServer $emailserver
            Write-Output "$timestamp : ERROR: Service Is NOT running!" | Out-File -Append $outfile
            }
            Else{
            Send-MailMessage -From $sender -To $receiver -Subject "$env:COMPUTERNAME SERVICE WARNING" -Body "Service stopped and was restarted on $env:COMPUTERNAME! - Powershell Bot" -SmtpServer $emailserver
            Write-Output "$timestamp : WARNING: Service stopped and was restarted!" | Out-File -Append $outfile
            }
    }

    
    Start-Sleep -Seconds $polltime
    $timestamp = Get-Date
}

if($counter -ne 0){
write-Output "$timestamp : Services Monitoring Ending for $timestamp with Errors" | Out-File -Append $outfile
Send-MailMessage -From $sender -To $receiver -Subject "$env:COMPUTERNAME SERVICES MONITORING ENDING" -Body "Services Monitoring has ended with $counter errors for $filetimestamp on $env:COMPUTERNAME. Please check the log on $env:COMPUTERNAME : $outfile -  Powershell Bot" -SmtpServer $emailserver
}
Else{
write-Output "$timestamp : Services Monitoring Ending for $timestamp" | Out-File -Append $outfile
Send-MailMessage -From $sender -To $receiver -Subject "$env:COMPUTERNAME SERVICES MONITORING ENDING" -Body "Services Monitoring has ended for $filetimestamp on $env:COMPUTERNAME. There were no errors today. - Powershell Bot" -SmtpServer $emailserver
}
            