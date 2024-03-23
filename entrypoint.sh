#!/bin/sh

# Function to install dependencies
build_one_nms() {
    version=$1

    # Create directory for build
    mkdir -p "nms-build_${version//./_}"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create directory for version $version"
        return 1
    fi
    cd "nms-build_${version//./_}" || return 1

    # Download BuildTools.jar
    wget -O BuildTools.jar "https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to download BuildTools.jar for version $version"
        cd ..
        return 1
    fi

    # Determine Java version based on provided Minecraft version
    case $version in
        1.17 | 1.16* | 1.15* | 1.14* | 1.13* | 1.12* | 1.11* | 1.10* | 1.9* | 1.8*)
            echo "Using java8"
            export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
            ;;
        *)
            echo "Using java17"
            export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
            ;;
    esac

    # Set the JAVA_EXE variable
    JAVA_EXE="$JAVA_HOME/bin/java"

    echo "Using java: $JAVA_HOME"
    echo "Using Java executable: $JAVA_EXE"

    # Run BuildTools.jar with the specified version
    "$JAVA_EXE" -jar BuildTools.jar --rev "$version"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to build version $version"
        cd ..
        return 1
    fi

    cd ..
}

# Check if versions are provided as arguments
if [ "$#" -eq 0 ]; then
    echo "No versions provided. Please provide versions as comma-separated list."
    exit 1
fi

# Iterate through provided versions
for version in "$@"; do
    build_one_nms "$version" || exit 1
done

# Install to github .m2
mkdir -p .m2/repository
if [ $? -ne 0 ]; then
    echo "Error: Failed to create .m2/repository directory"
    exit 1
fi

echo "Copying from /root/.m2/repository to $PWD/.m2/repository"
cp -r /root/.m2/repository/. .m2/repository || exit 1
