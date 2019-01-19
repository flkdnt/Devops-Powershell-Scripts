<#
.Synopsis
DANGEROUS!

Restarts List of Servers -Dante Foulke, 2018

.Description
Restarts List of servers specified in $computerfile variable. 

THIS SCRIPT IS DANGEROUS, DO NOT RUN ON THE INCORRECT SERVERS!

.Example
Example1: To Run locally:

Restart-computer -Force

#>

$computerfile = get-content "FILEPATH\FILE.txt"

ForEach ($computer in $computerfile) {
Restart-Computer -ComputerName $computer -Force
}