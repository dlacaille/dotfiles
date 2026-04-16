#!/bin/bash
while true;
do
  /usr/bin/flatpak run --branch=stable --arch=x86_64 --command=easyeffects com.github.wwmm.easyeffects --gapplication-service
  sleep 1s
done

