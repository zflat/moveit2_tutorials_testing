# MoveIt workspace and demo testing

## Prerequisites

* Ubuntu with the following installed
  * Docker with NVIDIA Container Toolkit
    * Install following https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html
  * [Dev Container CLI](https://github.com/devcontainers/cli) OR VSCode with the [devcontainers](https://code.visualstudio.com/docs/devcontainers/containers) extension.

## Setup and running
* On the host machine, run the following
  ```
  docker build -t moveit2_tutorials:latest .
  docker exec -it -u $(id -u) $(devcontainer up --workspace-folder . | jq -r .containerId) bash
  ```
* Within the container terminal
  ```
  source ~/ws_moveit2/install/setup.bash
  ros2 launch moveit2_tutorials demo.launch.py rviz_tutorial:=false
  ```

