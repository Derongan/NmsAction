#!/bin/sh -l

wget -O BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

java -jar BuildTools.jar --rev $1

# Install to github .m2
mkdir -p $HOME/.m2
echo "Copying from /root/.m2 to $HOME/.m2"
cp -a /root/.m2/. $HOME/.m2