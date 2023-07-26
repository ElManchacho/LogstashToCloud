# Define global variables

$file = "elastic-agent-8.8.2-windows-x86_64"

$zipFile = "$file.zip"

$enrollementToken = "Wmt0R2tZa0JuRTZSYnY3UGYtNGY6WWhyems4VnZUeE9Qc2VZUmNxV3gzUQ=="

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
  --fleet-server-es=https://f8f4b3970a5e45d387eea4cdcbf5ec23.eu-west-3.aws.elastic-cloud.com:443 `
  --fleet-server-service-token=AAEAAWVsYXN0aWMvZmxlZXQtc2VydmVyL3Rva2VuLTE2OTAzNzYxMjg2NzY6eHQ3TTM4NGFRU3FXd05Rbk1FMDlsUQ `
  --fleet-server-policy=44ceca40-2bb2-11ee-8cd6-b70a4ff5323c `
  --fleet-server-port=8220

#-----------------------------------------------------------------#

# Check if zip file has already been downloaded

# $existingZipFile = Test-Path $zipFile


# #----------------------------------------------------------------#
# ###### This part of the script comes from the Elastic Agent ######
# ######      integration commands provided by Elastic        ######
# #----------------------------------------------------------------#

# # Get 8.8.2 version of zipped elastic-agent

# if ( !$existingZipFile )
# {
#     Invoke-WebRequest -Uri "https://artifacts.elastic.co/downloads/beats/elastic-agent/$zipFile" -OutFile $zipFile
# }

# # Ask to delete existing agent or not

# sc.exe delete "Elastic Agent"

# Remove-Item $location"\$file"

# # Unzip it

# Expand-Archive -Path $location"\$zipFile" -DestinationPath $location

# # Go into the newly unzipped elastic agent folder and install it

# cd $file

# .\elastic-agent.exe install --url=https://df6095956c724821a05a4fed766f6958.fleet.eu-west-3.aws.elastic-cloud.com:443 --enrollment-token=$enrollementToken

# #----------------------------------------------------------------#

