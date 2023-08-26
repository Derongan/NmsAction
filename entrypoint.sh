#!/bin/sh -l
mkdir nms-build
cd nms-build

wget -O BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

version=$1

# Older than 1.17 is java8
# 1.17.1 is java16
# Newer than 1.17.1 is java17
case $version in
  1.17.1)
    echo "Using java16"
    export JAVA_HOME=/usr/lib/jvm/java-16-openjdk
    ;;
 1.17* | 1.16* | 1.15* | 1.14* | 1.13* | 1.12* | 1.11* | 1.10* | 1.9* | 1.8*)
    echo "Using java8"
    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
    ;;
  *)
    echo "Using java17"
    export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
    ;;
esac

# Set the JAVA_EXE variable
JAVA_EXE=$JAVA_HOME/bin/java

echo "Using java: $JAVA_HOME"
echo "Using Java executable: $JAVA_EXE"

# Run BuildTools.jar with the specified version
$JAVA_EXE -jar BuildTools.jar --rev $version

# Install to github .m2
mkdir -p .m2/repository
echo "Copying from /root/.m2/repository to $PWD/.m2/repository"
cp -a /root/.m2/repository/. .m2/repository
