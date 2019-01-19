<#
.Synopsis
   This script will run indefintely to create Network traffic for testing purposes. - Dante Foulke, 2018
    
.DESCRIPTION
   This script requires a MANUAL start and stop, otherwise, it'll run forever.
   To Modify, change the following Variables:

        $Server = "SERVNAME OR URL"         SERVERNAME, IP, PORT NUMBER
        $Port = "PORT NUMBER"               NUMERICAL PORT NUMBER
        $polltime = "POLL TIME IN SECONDS"  NUMBER VALUE IN SECONDS
#>


$Server = "SERVNAME OR URL"
$Port = "PORT NUMBER"
$polltime = "POLL TIME IN SECONDS"

$count=0
while($count -lt 1){

Test-NetConnection -computername $Server -Port $Port
Start-sleep -Seconds $polltime

}

