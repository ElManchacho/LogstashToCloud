# Define global variables

$file = "elastic-agent-8.8.2-windows-x86_64"

$zipFile = "$file.zip"

$enrollementToken = "<enrollement_token>"

$location = (Get-Location).Path

#$ProgressPreference = 'SilentlyContinue'

#-----------------------------------------------------------------#
####### This part of the script comes from the Fleet Server #######
#######      integration commands provided by Elastic       #######
#-----------------------------------------------------------------#


$existingZipFile = Test-Path $zipFile

if ( !$existingZipFile )
{
    Invoke-WebRequest -Uri "https://artifacts.elastic.co/downloads/beats/elastic-agent/$zipFile" -OutFile $zipFile
}

Remove-Item $location"\$file" -recurse

sc.exe delete "Elastic Agent"

Expand-Archive -Path $location"\$zipFile" -DestinationPath $location
cd $file
.\elastic-agent.exe install `
  --fleet-server-es=<endpoint> `
  --fleet-server-service-token=<token> `
  --fleet-server-policy=<policy-name-or-id> `
  --fleet-server-port=8220

#-----------------------------------------------------------------#

# Check if zip file has already been downloaded

$existingZipFile = Test-Path $zipFile

#----------------------------------------------------------------#
###### This part of the script comes from the Elastic Agent ######
######      integration commands provided by Elastic        ######
#----------------------------------------------------------------#

# Get 8.8.2 version of zipped elastic-agent

if ( !$existingZipFile )
{
    Invoke-WebRequest -Uri "https://artifacts.elastic.co/downloads/beats/elastic-agent/$zipFile" -OutFile $zipFile
}

# Ask to delete existing agent or not

sc.exe delete "Elastic Agent"

Remove-Item $location"\$file"

# Unzip it

Expand-Archive -Path $location"\$zipFile" -DestinationPath $location

# Go into the newly unzipped elastic agent folder and install it

cd $file

.\elastic-agent.exe install --url=https://<endpoint> --enrollment-token=$enrollementToken

#----------------------------------------------------------------#

