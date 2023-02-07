#!/bin/bash

#Change the local paths as per your convenience

PackagePath="/Users/abhinavraman/Desktop/awsJar/jars"

config(){

cd /Users/abhinavraman/Desktop

git clone git@github.com:itorix/apiwiz-prod-config.git

cd /Users/abhinavraman/Desktop/apiwiz-prod-config

git checkout main

cp -r /Users/abhinavraman/Desktop/apiwiz-prod-config/*  /Users/abhinavraman/Desktop/aws_final/apps/coreapps/config

}


zipandship(){

zip -r apps.zip /Users/abhinavraman/Desktop/aws_final/apps/*

cd /Users/abhinavraman/Desktop/aws_final/apps/

aws s3 cp apps.zip s3://apiwiz-nonprod-onprem-installation/1.22.12/

}


copyjars(){

cp -r /Users/abhinavraman/Desktop/aws/p4j/*  /Users/abhinavraman/Desktop/aws_final/apps/coreapps

}


download_jars(){

S3_PATH="s3://apiwiz-platform-build-packages/itorix-build-jar"

s3location=${S3_PATH}/${2}/stage/${1}

files=$(aws s3 ls ${s3location} --recursive | sort |  tail -n 1 | awk '{print $4}')

filename=${files}

aws s3 cp s3://apiwiz-platform-build-packages/"${filename}" $PackagePath


sed -i '' "s/-Dconfig.*/-Dconfig.properties\=\/opt\/apiwiz\/core\/Config\/${1}\/config.properties]/" /Users/abhinavraman/Desktop/aws/task.yml

sed -i '' "s/springBootJarFile.*/springBootJarFile: \/Users\/abhinavraman\/Desktop\/awsJar\/jars\/${3}/" /Users/abhinavraman/Desktop/aws/task.yml

sed -i '' "s/exeFileName.*/exeFileName: '${1}'/" /Users/abhinavraman/Desktop/aws/task.yml

sed -i '' "s/outputFolder.*/outputFolder: \/Users\/abhinavraman\/Desktop\/aws\/p4j\/${1}/" /Users/abhinavraman/Desktop/aws/task.yml

/Applications/Protector4J.app/Contents/protector4j-mac/p4j -t spring-boot -f /Users/abhinavraman/Desktop/aws/task.yml -u billing@itorix.com -p 'C2!Y/Ejbd2'

}





        case $1 in
            -p)  shift
                 PROFILE="${1}"
                 echo "Got Profile as $PROFILE"
                 shift
        esac
        
      
        
        

case $PROFILE in
            all)
                       echo " installation"
                         download_jars core-api apiwiz-core-platform-api-v2 cloud-app-0.0.1-SNAPSHOT.jar
                         download_jars monitor-api apiwiz-monitor monitor-api-1.0-RELEASE.jar
                         download_jars monitor-agent apiwiz-monitor monitor-agent-1.0-RELEASE.jar
                         download_jars mock-api apiwiz-mock mock-api-1.0-SNAPSHOT.jar
                         download_jars mock-agent apiwiz-mock mock-agent-1.0-SNAPSHOT.jar
                         download_jars consent-api apiwiz-consent consent-api-1.0-SNAPSHOT.jar
                         download_jars consent-agent apiwiz-consent consent-agent-1.0-SNAPSHOT.jar
                         download_jars notification-agent apiwiz-notification notification-agent-1.0.SNAPSHOT.jar
#                         download_jars sso-api apiwiz-core-platform-api .jar
                         download_jars testsuite-api apiwiz-testsuite-api testsuite-api-1.0-SNAPSHOT.jar
                         download_jars testsuite-agent apiwiz-testsuite-api testsuite-agent-1.5.10.RELEASE.jar
                         download_jars linter-api apiwiz-linter linter-api-0.1.jar
                         download_jars linter-agent apiwiz-linter linter-agent-0.1.jar
                         download_jars inspector-api apiwiz-api-inspector inspector-api-0.1.jar
                         download_jars inspector-agent apiwiz-api-inspector inspector-agent-0.1.jar
                         download_jars api-checker apiwiz-api-compliance api-checker.jar
                         download_jars api-reports apiwiz-api-compliance api-reports.jar
                         download_jars api-scanner apiwiz-api-compliance api-scanner.jar
                         download_jars kong-connector apiwiz-kong-connector kong-connector.jar
                         ;;
          core-api)  #TODO add core-api installation steps here
                        echo "core-api installation"
                        download_jars core-api apiwiz-core-platform-api-v2 cloud-app-0.0.1-SNAPSHOT.jar
                        ;;
          monitor)  #TODO add monitor-api installation steps here
                         download_jars monitor-api apiwiz-monitor monitor-api-1.0-RELEASE.jar
                         download_jars monitor-agent apiwiz-monitor monitor-agent-1.0-RELEASE.jar
                        ;;
          mock)  #TODO add mock installation steps here
                         download_jars mock-api apiwiz-mock mock-api-1.0-SNAPSHOT.jar
                         download_jars mock-agent apiwiz-mock mock-agent-1.0-SNAPSHOT.jar
                        ;;
          consent)  #TODO add consent-api installation steps here
                         download_jars consent-api apiwiz-consent consent-api-1.0-SNAPSHOT.jar
                         download_jars consent-agent apiwiz-consent consent-agent-1.0-SNAPSHOT.jar
                        ;;
          notification-agent)  #TODO add notification installation steps here
                        echo "notification installation"
                        download_jars notification-agent apiwiz-notification notification-agent-1.0.SNAPSHOT.jar
                        ;;
#          sso-api)  #TODO add sso-api installation steps here
#                        echo "sso-api installation"
#                         download_jars sso-api apiwiz-core-platform-api .jar
#                        ;;
          testsuite)  #TODO add testsuite installation steps here
                        echo "testsuite installation"
                         download_jars testsuite-api apiwiz-testsuite-api testsuite-api-1.0-SNAPSHOT.jar
                         download_jars testsuite-agent apiwiz-testsuite-api testsuite-agent-1.5.10.RELEASE.jar
                        ;;
          linter)  #TODO add linting installation steps here
                        echo "linter installation"
                         download_jars linter-api apiwiz-linter linter-api-0.1.jar
                         download_jars linter-agent apiwiz-linter linter-agent-0.1.jar
                        ;;
          inspector)  #TODO add inspector installation steps here
                        echo "inspector installation"
                         download_jars inspector-api apiwiz-api-inspector inspector-api-0.1.jar
                         download_jars inspector-agent apiwiz-api-inspector inspector-agent-0.1.jar
                        ;;
          compliance)  #TODO add linting installation steps here
                        echo "compliance installation"
                         download_jars api-checker apiwiz-api-compliance api-checker.jar
                         download_jars api-reports apiwiz-api-compliance api-reports.jar
                         download_jars api-scanner apiwiz-api-compliance api-scanner.jar
                        ;;
          kong)  
                        echo "kong installation"
                        download_jars kong-connector apiwiz-kong-connector kong-connector.jar
                        ;;
        *)              echo "please check usage"
        esac


copyjars
config
zipandship
