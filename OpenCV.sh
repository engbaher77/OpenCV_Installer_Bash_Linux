#!/bin/bah
apt-install python3-pip

sudo apt-get update \
    && sudo apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        git \
        wget \
        unzip \
        yasm \
        pkg-config \
        libswscale-dev \
        libtbb2 \
        libtbb-dev \
        libjpeg-dev \
        libpng-dev \
        libopenjp2-7-dev \
        libavformat-dev \
        libpq-dev \
        qtbase5-dev \
        qtdeclarative5-dev \
        libgtk2.0-dev \
        pkg-config 

    pip3 install numpy
    wget -q https://github.com/opencv/opencv/archive/4.5.1.zip -O opencv.zip
    wget -q https://github.com/opencv/opencv_contrib/archive/4.5.1.zip -O contrib.zip
    unzip -qq opencv.zip -d /opt
    unzip -qq contrib.zip -d /opt
    rm -rf opencv.zip
    rm -rf contrib.zip
    cd /opt
    mv opencv-4.5.1 opencv
    mv opencv_contrib-4.5.1 opencv_contrib
    cd opencv
    mkdir release
    cd release

    cmake \
        -D WITH_QT=ON .. \
        -D BUILD_TIFF=ON \
        -D BUILD_opencv_java=OFF \
        -D WITH_CUDA=OFF \
        -D ENABLE_AVX=OFF \
        -D WITH_OPENGL=OFF \
        -D WITH_OPENCL=OFF \
        -D WITH_IPP=OFF \
        -D WITH_TBB=ON \
        -D BUILD_TBB=ON \
        -D WITH_EIGEN=OFF \
        -D WITH_V4L=OFF \
        -D WITH_VTK=OFF \
        -D BUILD_TESTS=OFF \
        -D BUILD_PERF_TESTS=OFF \
        -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D OPENCV_EXTRA_MODULES_PATH=/opt/opencv_contrib/modules /opt/opencv/ \
    && make -j4 \
    && make install \
    && ldconfig \
    && rm -rf /opt/build/* \
    && rm -rf /opt/opencv-4.5.1 \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get -qq autoremove \
    && apt-get -qq clean

