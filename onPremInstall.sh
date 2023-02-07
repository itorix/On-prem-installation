#!/bin/bash

#Change the local paths as per your convenience

PackagePath="/var/lib/jenkins/workspace/OnPreminstallation/jars"


zipandship(){

zip -r apps.zip /var/lib/jenkins/workspace/OnPreminstallation/apps/*

cd /var/lib/jenkins/workspace/OnPreminstallation/apps/

aws s3 cp apps.zip s3://apiwiz-nonprod-onprem-installation/1.22.12/

}


copyjars(){

cp -r /var/lib/jenkins/workspace/OnPreminstallation/encryptedJars/*  /var/lib/jenkins/workspace/OnPreminstallation/apps/coreapps

}


download_jars(){

S3_PATH="s3://apiwiz-platform-build-packagess/itorix-build-jar"

s3location=${S3_PATH}/${2}/stage/${1}

files=$(aws s3 ls ${s3location} --recursive | sort |  tail -n 1 | awk '{print $4}')

filename=${files}

aws s3 cp s3://apiwiz-platform-build-packages/"${filename}" $PackagePath


sed -i '' "s/-Dconfig.*/-Dconfig.properties\=\/opt\/apiwiz\/core\/Config\/${1}\/config.properties]/" /var/lib/jenkins/workspace/OnPreminstallation/task.yml

sed -i '' "s/springBootJarFile.*/springBootJarFile: \/var\/lib\/jenkins\/workspace\/OnPreminstallation\/jars\/${3}/" /var/lib/jenkins/workspace/OnPreminstallation/task.yml

sed -i '' "s/exeFileName.*/exeFileName: '${1}'/" /var/lib/jenkins/workspace/OnPreminstallation/task.yml

sed -i '' "s/outputFolder.*/outputFolder: \/var\/lib\/jenkins\/workspace\/OnPreminstallation\/encryptedJars\/${1}/" /var/lib/jenkins/workspace/OnPreminstallation/task.yml

/Applications/Protector4J.app/Contents/protector4j-mac/p4j -t spring-boot -f /var/lib/jenkins/workspace/OnPreminstallation/task.yml -u billing@itorix.com -p 'C2!Y/Ejbd2'

}





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
         *)              echo "please check usage"
         


copyjars
#config
zipandship
