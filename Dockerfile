# FROM nvidia/cuda:8.0-cudnn7-devel
FROM ubuntu:16.04

MAINTAINER Lionel Atty <yoyonel@hotmail.com>

RUN mkdir OpenCV && cd OpenCV

RUN apt-get update && apt-get install -y \
      build-essential \
      checkinstall \
      cmake \
      pkg-config \
      yasm \
      libtiff5-dev \
      libjpeg-dev \
      libjasper-dev \
      libavcodec-dev \
      libavformat-dev \
      libswscale-dev \
      libdc1394-22-dev \
      libxine2-dev \
      libgstreamer0.10-dev \
      libgstreamer-plugins-base0.10-dev \
      libv4l-dev \
      python-dev \
      python-numpy \
      python-pip \
      libtbb-dev \
      libeigen3-dev \
      libqt4-dev \
      libgtk2.0-dev \
      # Doesn't work libfaac-dev \
      libmp3lame-dev \
      libopencore-amrnb-dev \
      libopencore-amrwb-dev \
      libtheora-dev \
      libvorbis-dev \
      libxvidcore-dev \
      x264 \
      v4l-utils \
     # Doesn't work ffmpeg \
      libgtk2.0-dev \
    #  zlib1g-dev \
    #  libavcodec-dev \
      unzip \
      wget

# https://github.com/opencv/opencv/issues/6677
RUN apt-get install -y git libhdf5-dev
# wget https://github.com/Itseez/opencv/archive/3.1.0.zip -O opencv-3.1.0.zip -nv && \
#     unzip opencv-3.1.0.zip && \
#     cd opencv-3.1.0 && \
RUN cd /opt && \
    git clone https://github.com/daveselinger/opencv opencv-3.1.0 && \
    cd opencv-3.1.0 && \
    git checkout 3.1.0-with-cuda8 && \
    rm -rf build && \
    mkdir build && \
    cd build && \
    cmake -D CUDA_ARCH_BIN=3.2 \
      -D CUDA_ARCH_PTX=3.2 \
      -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D WITH_TBB=ON \
      -D BUILD_NEW_PYTHON_SUPPORT=ON \
      -D WITH_V4L=ON \
      -D BUILD_TIFF=ON \
      -D WITH_QT=ON \
   #   -D USE_GStreamer=ON \
      -D WITH_OPENGL=ON .. && \
    make -j7 && \
    make install && \
    echo "/usr/local/lib" | tee -a /etc/ld.so.conf.d/opencv.conf && \
    ldconfig
RUN cp /opt/opencv-3.1.0/build/lib/cv2.so /usr/lib/python2.7/dist-packages/cv2.so




