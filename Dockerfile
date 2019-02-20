FROM debian:jessie

WORKDIR /workdir
ENV LINUX=/workdir/rpi64-linux \
    RPI_KERNEL_REPO=https://www.github.com/raspberrypi/linux \
    RPI_KERNEL_BRANCH=rpi-4.14.y \
    RPI_KERNEL_COMMIT=877656cd145497db7c09a7de06ea85db98bd72a3

# Install build dependencies
RUN apt-get update && \
  apt-get install -y bc build-essential curl git-core libncurses5-dev module-init-tools

# Install crosscompile toolchain for ARM64/aarch64
RUN mkdir -p /opt/linaro && \
  curl -sSL http://releases.linaro.org/components/toolchain/binaries/7.4-2019.02/aarch64-linux-gnu/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu.tar.xz | tar xfJ - -C /opt/linaro
ENV CROSS_COMPILE=/opt/linaro/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-

COPY defconfigs/ /defconfigs/
COPY build-kernel.sh version /
CMD ["/build-kernel.sh"]
