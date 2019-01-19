<#
.Synopsis
    This is a Baseline installer template. This is NOT a silent Install. -Dante Foulke, 2018
.Description
    This Template contains the following:

First Section Contaings the Basic functions to get started:
    A Sample program so you can setup pre-defined software packages per Server-Type, etc.
    
The Second Section contains sample Install Steps:

    1. How to Create Folders if they don't already exist
    2. How to Copy File and Folders
    3. How to unzip a file
    4. How to install


To Run:
    1. Copy the script to the local machine 
    2. Navigate to the filepath 
    3. Run the command in the example

.Example
    ./Server Baseline Script.ps1 -Servertype SERVERTYPE
#>

<# -----------------------
    START SAMPLE PROGRAM
#>

[CmdletBinding()]
    Param(
        [parameter(Mandatory=$true,
        ValueFromPipeline=$true)]
        [String]
        $Servertype
    )

<#
-----------------------SCRIPT PREP-----------------------
#>
$localpath="FILEPATH_HERE"
$servertype1= "SERVERTYPE_HERE"
$servertype2= "SERVERTYPE_HERE"
$timestamp = get-date -Format yyyy-MM-dd__HH-mm-ss
$logfile="$localpath\Baseline_$timestamp.txt"
$path = $localpath

If(!(test-path $path))  { New-Item -ItemType Directory -Force -Path $path }
New-Item -Path $logfile -Force

function Write-InstallLog{
    [CmdletBinding()]
    Param(
        [parameter(Mandatory=$true,
        ValueFromPipeline=$true, Position=0)]
        [String[]]
        $Message,

        [parameter(Mandatory=$true,
        ValueFromPipeline=$true, Position=1)]
        [String]
        $Path,

        [parameter(
        Mandatory=$false,
        ValueFromPipeline=$true, 
        Position=1)]
        [String]
        $Color
    )
    if($Color -eq ""){$Color = "White"}

    $timestamp = get-date -Format yyyy-MM-dd__HH-mm-ss
    Write-Output "$timestamp : $Message" | Out-file $Path -Append
    # Debug 
    # Write-Host "$Message" -ForegroundColor $Color
    $Color = "White"
}


    if( $Servertype -like $servertype1 ){
        $program1="y"
        $program2="y"
        $program3="y"
        Write-InstallLog -Message "Server Type is $Servertype" -Path $logfile
    }

    if( $Servertype -like $servertype2 ){
        $program1="y"
        $program2="y"
        $program3="n"
        Write-InstallLog -Message "Server Type is $Servertype" -Path $logfile
    }

# Program1
if($program1 -like "y"){
    #INSTALL STEPS
}

# Program2
if($program2 -like "y"){
    #INSTALL STEPS
}

# Program3
if($program3 -like "y"){
    #INSTALL STEPS
}



<#  ----------------------------

    END SAMPLE PROGRAM

    START SAMPLE INSTALL STEPS

    ----------------------------
#>

#Pre-Create files if they don't exist
$path = "FILEPATH"
  If(!(test-path $path)){
        New-Item -ItemType Directory -Force -Path $path
  }

#To Copy A File:
copy-item "FILEPATH\FILE.msi" "DESTINATION"

#To Copy A Folder:
copy-item "FILEPATH" "DESTINATION" -recurse

#To UNZIP a Zipfile(Powershell V2):
$shell = New-Object -ComObject shell.application
$zip = $shell.NameSpace("FILEPATH\FILE.zip")
foreach ($item in $zip.items()) {
  $shell.Namespace("FILEPATH").CopyHere($item)
}

#To install:
Start-Process "FILEPATH\FILE.exe" -Wait
Start-Process "FILEPATH\FILE.msi"
Start-Process "FILEPATH\FILE.bat" -Wait

<#
    END SAMPLE INSTALL STEPS
#>