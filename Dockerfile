FROM ubuntu:19.10
LABEL maintainer "linhvnguyen9 <linhvnguyen9@gmail.com>"

ENV ANDROID_HOME "/android-sdk"
ENV ANDROID_COMPILE_SDK "28"
ENV ANDROID_BUILD_TOOLS "28.0.3"
ENV ANDROID_SDK_TOOLS "3859397"
ENV PATH "$PATH:${ANDROID_HOME}/platform-tools"

RUN apt-get update && \
    apt-get install -y \
        git \
        bash \
        curl \
        wget \
        ruby \
        ruby-dev \
        build-essential

RUN gem install fastlane -NV

ADD https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip sdk-tools-linux.zip

RUN unzip sdk-tools-linux.zip -d ${ANDROID_HOME} && \
    rm sdk-tools-linux.zip && \
    echo y | ${ANDROID_HOME}/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" "build-tools;${ANDROID_BUILD_TOOLS}"

#firebase-tools setup
ADD https://github.com/firebase/firebase-tools/releases/download/v7.3.1/firebase-tools-linux firebase-tools-linux
RUN chmod +x firebase-tools-linux
RUN ./firebase-tools-linux --open-sesame appdistribution 
