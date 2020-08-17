FROM rust:buster

LABEL version 1

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
  build-essential git ca-certificates pkg-config libusb-1.0-0-dev gcc-arm-none-eabi libstdc++-arm-none-eabi-newlib

WORKDIR /root

RUN mkdir /root/bin /root/src

RUN cd src && \
  git clone https://github.com/OpenAnnePro/AnnePro2-Tools.git && \
  git clone https://github.com/OpenAnnePro/qmk_firmware.git --recursive --depth 1 && \
  git clone https://github.com/OpenAnnePro/AnnePro2-Shine.git --recursive --depth 1

RUN rm -rf src/qmk_firmware/keyboards/annepro2/keymaps/codetector

RUN cd src/AnnePro2-Tools && cargo build --release && cp target/release/annepro2_tools /root/bin/
RUN cd src/AnnePro2-Shine && make && cp build/annepro2-shine.bin /root/bin

COPY keymap.c src/qmk_firmware/keyboards/annepro2/keymaps/default/keymap.c

RUN cd src/qmk_firmware && make annepro2/c15 && cp -R .build/* /root/bin/