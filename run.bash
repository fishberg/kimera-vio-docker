#/usr/bin/env bash
#docker run -it kimera-vio-docker

docker run -it --rm --net=host -v $(pwd)/bridge:/root/bridge kimera-vio-docker
