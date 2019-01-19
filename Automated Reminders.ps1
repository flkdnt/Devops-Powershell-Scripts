<#
.Synopsis
   Weekly Email Reminders(Monday) - Dante Foulke, 2018

.DESCRIPTION
    Fill out the Below Variables To change the script:
        
    $Sender = "SENDER EMAIL"
    $Receiver = "RECEIVER EMAIL"
    $smtpserver = "SMTPSERVER"
    $subject = "EMAIL SUBJECT"

#>

$datenumber = (Get-Date).DayOfYear
$weekday = (Get-Date).DayOfWeek
#$month = (Get-Date).Month
#$yesterday = (Get-Date).AddDays(-1).Month

if( $weekday -eq "Monday"){ 
    $Monday = "YES" 
}

$Sender = "SENDER EMAIL"
$Receiver = "RECEIVER EMAIL"
$smtpserver = "SMTPSERVER"
$subject = "EMAIL SUBJECT"
$Monday_Message = "Hello, Here are your reminders for today: <br/><br/>
    <br/><br/> Thank You, and Have a great Monday! <br/><br/>"


if($Monday -eq "YES"){
    Send-MailMessage -From $Sender -To $Receiver -Subject $subject -Body $Monday_Message -SmtpServer $smtpserver -BodyAsHtml
}