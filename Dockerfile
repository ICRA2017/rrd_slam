FROM ros:indigo-perception

RUN git clone https://github.com/ICRA2017/rrd_slam.git

RUN rm /bin/sh \
	&& ln -s /bin/bash /bin/sh

RUN apt-get update && apt-get install -y \
	libqglviewer-dev \
	freeglut3 freeglut3-dev \
	libceres-dev \
	libsuitesparse-dev \
	&& rm -rf /var/lib/apt/lists

RUN source /ros_entrypoint.sh \
	&& export ROS_PACKAGE_PATH=/rrd_slam:$ROS_PACKAGE_PATH \
	&& cd rrd_slam \
	&& rosmake lsd_slam_core lsd_slam_viewer
