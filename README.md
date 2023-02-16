# README.md

Simple Docker container (with a few fixes) to run Kimera-VIO's public repositories. The instructions below assume minimal knowledge of Docker (and thus may appear verbose to more experienced users).

See [notes.md](./notes.md) for details on what changes were made.


# Usage
## 1. Install Docker
* `./docker-install_ubuntu-20.04.bash`
    * Installs Docker on your system. If you already have Docker installed, skip this step.
    * Script assumes you are running Ubuntu 20.04. If you're not, consult an appropriate reference to install (don't use this script). You want Docker Engine (not Docker Desktop).
    * [Official Docker Documentation (Ubuntu)](https://docs.docker.com/engine/install/ubuntu/)
    * [DigitalOcean's Documentation (Ubuntu 20.04)](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04)
    * This script based off on DigitalOcean's instructions (I find them more straight forward than Docker's official instructions).
* `docker run hello-world`
    * Test Docker installed properly. If you see "Hello from Docker!" message (followed by a bunch of other output), things worked.
    * First time you run this command it will download the `hello-world` image from the DockerHub, this is expected.

## 2. Build Docker Image
* `./build.bash`
    * Builds the Docker image. Will take ~30min, even on fast computers.

## 3. Run Docker Image
* `./run.bash`
    * Runs the Docker image. Bridges network. If you have ROS1 installed on your host system, you should be able to see a bunch of topics by typing `rostopic list`

## 4. Add data
* `rosbag play test-data.bag`
    * TODO add a bag file (these files get big since it contains stereo images + IMU data)
* Run a RealSense D435i
    * TODO add correct IMU settings and topic names

# Repository Layout
* `README.md`: this file
* `Dockerfile`: recipe for `kimera-vio-docker` image
* `build.bash`: simple script to execute the `docker build` command
* `run.bash`: simple script to execute the `docker run` command
* `bridge`: directory that gets mounted as `/root/bridge` by `run.bash`
* `copy`: directory that contains files copied into image during its build; most notably `copy/entrypoint.bash`
* `copy/entrypoint.bash`: script that is run when image is executed; you can set `ROS_MASTER_URI` and `ROS_IP` in here; if you edit this file you need to re-run `build.bash`; if you comment out the `ENTRYPOINT ["/entrypoint.bash"]` line from `Dockerfile` (last line) and rebuild, you will simply get a terminal prompt when running
* `copy/mesh_rviz_plugins.patch`: small patch applied during to fix build
* `bridge/start.bash`: simple script to run the `roslaunch` command; useful if you launch to terminal prompt instead of a entrypoint script
* `docker-install_ubuntu-20.04.bash`: simple script to install `docker-ce` on Ubuntu 20.04; based on the [DigitalOcean instructions](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04)
* `notes.md`: documents which commits each repository was on at the time of writing; many of the rosinstall repos depend on various `master` branches (i.e. are not pinned to specific commits), so future commits could break this build; if the `build.bash` fails, use these notes to restore `Dockerfile` to a working state

# References
* [Kimera-VIO-ROS Repo](https://github.com/MIT-SPARK/Kimera-VIO-ROS)
* [Kimera-VIO-ROS Install Instructions](https://github.com/MIT-SPARK/Kimera-VIO-ROS/blob/master/README.md#1-installation)
* [Kimera-VIO-ROS RealSense D435i Setup](https://github.com/MIT-SPARK/Kimera-VIO-ROS/blob/master/docs/hardware_setup.md)

# TODO
* Add sample `test-data.bag` file
* Add instructions for `rosbag play`
* Add instructions for RealSense D435i
* Push DockerHub image
