FROM ros:indigo-perception

RUN git clone https://github.com/ICRA2017/rrd_slam.git

RUN rm /bin/sh \
	&& ln -s /bin/bash /bin/sh

RUN apt-get update && apt-get install -y \
	libqglviewer-dev \
	freeglut3 freeglut3-dev \
	libceres-dev \
	libsuitesparse-dev \
	libeigen3-dev \
	software-properties-common \
	&& rm -rf /var/lib/apt/lists

RUN add-apt-repository ppa:george-edison55/cmake-3.x \
	&& apt-get update && apt-get install -y \
	cmake \
	qtbase5-dev \
	&& rm -rf /var/lib/apt/lists

RUN git clone https://github.com/RainerKuemmerle/g2o.git \
	&& cd g2o && mkdir build && cd build \
	&& cmake .. && make install

RUN source /ros_entrypoint.sh \
	&& export ROS_PACKAGE_PATH=/rrd_slam:$ROS_PACKAGE_PATH \
	&& cd rrd_slam \
	&& rosmake lsd_slam_core lsd_slam_viewer
