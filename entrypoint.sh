#!/bin/sh -l
mkdir nms-build
cd nms-build

wget -O BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

java -jar BuildTools.jar --rev $1

# Install to github .m2
mkdir -p $HOME/.m2/repository
echo "Copying from /root/.m2/repository to $HOME/.m2/repository"
ls /root/.m2/repository
cp -a /root/.m2/repository/. $HOME/.m2/repository