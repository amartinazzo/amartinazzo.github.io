---
date: 2019-04-10
title: "Arch Linux Troubleshooting"
---

This post is a work in progress. I will try and register here tweaks I've used in order to solve glitches after a fresh Arch Linux install with the xfce desktop environment. Things are written in a Q&A fashion in no particular order (that is, in random order :)).

### xfce takes forever to start.

clear the cache with `rm -rf .config/ .cache/ .gnome*` 

### there is no internet. wpa_supplicant is missing.

start a live Arch Linux environment (from a USB drive or CD), [chroot](https://wiki.archlinux.org/index.php/Chroot) to your system, and then install the packages required to connect to the internet.
```
pacman -S wpa_supplicant wireless_tools wpa_actiond dialog
```
<!-- https://bbs.archlinux.org/viewtopic.php?id=153711 -->

### volume keys don't work.

go to Settings > Keyboard > Application Shortcuts and add the commands:

`pactl -- set-sink-volume 0 +10%` for the shortcut XF86AudioRaiseVolume

`pactl -- set-sink-volume 0 -10%` for the shortcut XF86AudioLowerVolume

<!-- ### bluetooth doesn't work either. -->





