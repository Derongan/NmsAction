#!/bin/sh -l

# Function to install dependencies
install_dependencies() {
    # Create directory for build
    mkdir nms-build
    cd nms-build

    # Download BuildTools.jar
    wget -O BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

    version=$1

    # Determine Java version based on provided Minecraft version
    if [[ $version == 1.17* || $version == 1.16* || $version == 1.15* || $version == 1.14* || $version == 1.13* || $version == 1.12* || $version == 1.11* || $version == 1.10* || $version == 1.9* || $version == 1.8* ]]; then
        echo "Using java8"
        export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
    else
        echo "Using java17"
        export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
    fi

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
}

# Call the function with the version argument passed to the script
install_dependencies $1
