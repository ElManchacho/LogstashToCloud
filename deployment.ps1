#----------------------------------------------------------------#
###### This part of the script comes from the Elastic Agent ######
######      integration commands provided by Elastic        ######
#----------------------------------------------------------------#

# Define global variables

$file = "elastic-agent-8.8.2-windows-x86_64"

$zipFile = "$file.zip"

$enrollementToken = "Wmt0R2tZa0JuRTZSYnY3UGYtNGY6WWhyems4VnZUeE9Qc2VZUmNxV3gzUQ=="

#$ProgressPreference = 'SilentlyContinue'

# Get 8.8.2 version of zipped elastic-agent

Invoke-WebRequest -Uri "https://artifacts.elastic.co/downloads/beats/elastic-agent/$zipFile" -OutFile $zipFile

# Unzip it

Expand-Archive .\$zipFile -DestinationPath .$file

# Go into the newly unzipped elastic agent folder and install it

cd $file

.\elastic-agent.exe install --url=https://df6095956c724821a05a4fed766f6958.fleet.eu-west-3.aws.elastic-cloud.com:443 --enrollment-token=$enrollementToken

#----------------------------------------------------------------#