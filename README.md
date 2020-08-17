# OpenAnnePro Docker build script

This is a small script to build and flash the
[OpenAnnePro](https://github.com/OpenAnnePro) QMK firmware for the Anne Pro 2
keyboard. Requires docker.

Note: this script is for the c15 model only, but it should be easy to modify for
the c18 model. PRs welcome.

## Build and Flash

Run `./flash.sh` and follow the instructions.

## Custom keymap

You can change the keymap by modifying the `keymap.c` file. It is slightly
customized with the following changes:

* CAPSLOCK is bound to FN1

To revert to the default, remove it from the Dockerfile.