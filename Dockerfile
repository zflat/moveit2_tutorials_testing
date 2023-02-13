FROM ros:humble-ros-base-jammy

ARG USERNAME=guest
ARG USER_UID=5000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && echo "${USERNAME}:${USERNAME}" | chpasswd

WORKDIR /home/guest/ws_moveit2/src
RUN git clone https://github.com/ros-planning/moveit2_tutorials -b humble --depth 1 \
    && vcs import < moveit2_tutorials/moveit2_tutorials.repos

RUN apt-get update \
    && rosdep update --rosdistro=$ROS_DISTRO \
    && (rosdep install -r --from-paths . --ignore-src --rosdistro $ROS_DISTRO -y || true ) \
    && apt-get install -q -y --no-install-recommends \
    ros-$ROS_DISTRO-rmw-cyclonedds-cpp \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home/guest/ws_moveit2
RUN . /opt/ros/humble/setup.sh \
    && colcon build \
    && rm -r log

USER $USERNAME
