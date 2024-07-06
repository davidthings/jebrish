
# JEBRISH (Just Enough Build Root -ish)

<image src="README_D/images/powkiddy_x55.jpg" style="width: 23%; height: auto;">
<image src="README_D/images/powkiddy_rgb30.jpg" style="width: 15%; height: auto;">
<image src="README_D/images/RK2023WIFI.webp" style="width: 15%; height: auto;">
<image src="README_D/images/rg353m_glamour.webp" style="width: 15%; height: auto;">
<image src="README_D/images/zero3w_01.webp" style="width: 10%; height: auto;">


This is a fork of the [BuildRoot](https://buildroot.org/) project with some settings / config for RK3566-based handheld gaming devices.

It uses the U-Boot and Kernel Config developed for [JELOS](https://jelos.org/), the incredible handheld retrogaming OS.

The purpose of this fork is to provide a dead simple way to build a minimal Linux system for future RK3566-based devices that might want to run JELOS.  This can be a testbed for experimentation on things like like U-Boot, Device Tree, and the Kernel.

It attempts to address the situation that applies to a developer who wishes to help with the lower-level parts of the OS, but who is not intimately familiar with Linux or Jelos.  Jumping into the middle of the JELOS development environment can be *a lot*.  

BuildRoot provides a compact and well understood environment in which to do this work. Developers may already be familiar with it, and may be interested to learn if not. Very importantly, both build and boot times are short making for quick turnaround.  There are many online resources to explain BuildRoot.

But of course one can also work with JELOS directly!

Many variations are provided, with varying degrees of functionality.  The most minimal configuration is `jebrish_[device]_minimal_defconfig` which is just enough to boot and log in.  The most functional is `jebrish_[device]_gui_defconfig` which adds gui, wifi and DHCP. 

# Branches

**main** - this is the main Jebrish branch.  All the configurations are here.

**master** - this is the source BuildRoot branch.  It doesn't boot on the target devices.

Various other branches may appear from time to time as experiments are done.

# Configurations

BuildRoot configurations are of the form `[company]_[device]_deconfig`.  For the purposes here, each configuration will have an additional field describing additional features of note - `jebrish_[device]_[feature]_deconfig`.  Consistent with this, the actual "board"-specific files will appear in `board/jebrish/`.

**jebrish_rk3566_handheld_gui_defconfig** - this is a real-world configuration for generic rk3566 handhelds including Anbernic RGxx3-series, Powkiddy RGB30, X55 and R2023.  It has a non-volatile filesystem, Wayland / Weston graphics, and WiFi.

**jebrish_rk3566_handheld_headless_defconfig** - minimal system with WiFi and networking for RK3566-based handhelds.  With a tiny bit of external config, the system will connect to network on boot.  The network details can be set by editing `/etc/wpa_supplicant.conf`.  `DropBear` is added to provide an ssh server and mDNS so the device can be found by name on the network.

**jebrish_rk3566_handheld_minimal_defconfig** - minimal configuration for RK3566-based handhelds. It supplies just enough to boot and log in.  However since this is a minimal configuration, you'll need some extra hardware to make it useful.  Either you'll need to solder in a USB-UART in the case of UART console, or you'll need a USB keyboard in the case of Display/HDMI console.

There are also configurations for the Powkiddy X55 which has a slightly different design. 

**jebrish_rk3566_x55_minimal_defconfig**

**jebrish_rk3566_radxa_zero_3w_minimal_defconfig**


# Building

Build Prerequisites are set out in the BuildRoot [manual](https://buildroot.org/downloads/manual/manual.html#requirement)

On a machine set up to build BuildRoot, select a config, and run a command like this:

```
make jebrish_rk3566_handheld_gui_defconfig
make
```

Compilation on a reasonable machine with a reasonable internet connection should take about 30 minutes.

It may stop for various reasons - there may be a missing host tool, or perhaps a package didn't download correctly.  Check the output.  Mostly the culprit will be readily identifiable.

At the end of the process you should have a file `output/images/sdcard.img` which you can write to an SD card and boot on your device.

```
sudo dd if=output/images/sdcard.img of=/dev/sdc bs=4MB ; sync
```

# Console

Depending on your kernel arguments (in the boot partion `/extlinux/extlinux.conf`), console appears over the UART (at 1,500,00 bps!) or on the LCD display / HDMI.  Whichever appears last on the line is the one the console runs on.  Obviously if you select the main display, you'll need a USB keyboard or similar.  Many work, and a small wireless keyboard is quite nice.

This is the default: console runs on the display.  `console=tty0` is the second `console` hence the default for the shell.

```
LABEL default
  KERNEL /%LINUXIMAGE%
  FDTDIR /
  append root=PARTUUID=%PARTUUID% rootwait console=ttyS2,1500000 console=tty0 rootfstype=ext4 panic=10 loglevel=8
```

The alternative is that the console runs over the UART.  For this option you'll need to solder wires to connect a USB-UART.  Then you'll need to connect at 1,500,000 baud.    `console=ttyS2,1500000` is the second `console` hence the default for the shell.  See the [UART](#uart) section below for more information.

```
LABEL default
  KERNEL /%LINUXIMAGE%
  FDTDIR /
  append root=PARTUUID=%PARTUUID% rootwait console=tty0 console=ttyS2,1500000 rootfstype=ext4 panic=10 loglevel=8
```

You can change this file on the SD card, or in the source before you build (`board/jebrish/...`)

# Running

With the sd card in the first slot, power on.

Almost instantaneously, U-Boot SPL will run, then U-Boot proper.  If you're on the UART, you'll be given a brief moment to interupt the boot and type commands to U-Boot.  If you do nothing, the boot will continue.

After another very short period (2s or so), the kernel will run a console - either on the display or over the UART.

You should see kernel boot debug messages on the Display.  See example [here](README_D/boot_log.md).

Log in with username `root` and password `1234`

It's a real linux system!

```
# ls /
bin      init     linuxrc  opt      run      tmp
dev      lib      media    proc     sbin     usr
etc      lib64    mnt      root     sys      var
```

The messages on the display ought to convince you that the display is running.

Running evtest will let you see messages from all the input systems like the push buttons, analog sticks and touchscreen.

```
# evtest
No device specified, trying to scan all of /dev/input/event*
Available devices:
/dev/input/event0:      pwm-vibrator
/dev/input/event1:      rk805 pwrkey
/dev/input/event2:      Hynitron cst3xx Touchscreen
/dev/input/event3:      dw_hdmi
/dev/input/event4:      Logitech K600 TV
/dev/input/event5:      adc-keys
/dev/input/event6:      rk817_ext Headphones
/dev/input/event7:      adc-joystick
/dev/input/event8:      gpio-keys-control
/dev/input/event9:      gpio-keys-vol
Select the device event number [0-9]: 2
Input driver version is 1.0.1
Input device ID: bus 0x18 vendor 0x0 product 0x0 version 0x0
Input device name: "Hynitron cst3xx Touchscreen"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 330 (BTN_TOUCH)
  Event type 3 (EV_ABS)
```

# Actual Work

This site is a fork of BuildRoot.  It's almost entirely BuildRoot.  The only changes are in the `board/jebrish` directory, and the corresponding `configs/jebrish_[device]_[variation]_defconfig` files.

In the `board/jebrish` directory you'll find (in subdirectories) all the files and folders that BuildRoot uses to build a system. 

- `linux-patches` - Linux patches
- `linux.config` - kernel config
- `uboot-patches` - U-Boot patches
- `uboot.config` - a U-Boot config
- `post-build.sh` - a script mainly to create the contents of the boot partition
- `post-image.sh` - a script that runs `genimage` to create the sdcard.img file
- `extlinux.conf` - the extlinux config file for the boot partition (including kernel arguments)
- `genimage.cfg` - the layout of the sdcard.img file
- `rootfs-overlay` - a directory of files to be copied over the rootfs
- `patches` - General patches

`jebrish_rk3566_[variatios]_defconfig` are the config files. 

# Tested Devices

**Anbernic RK353M**
- working nicely

**Powkiddy RGB30**
- working nicely

**Powkiddy RG2023WiFi**
- working nicely

**Powkiddy X55**
- working nicely

**Radxa Zero 3W**
- minimal config works 
- WiFi (AIC8800) does *not* work with 6.x series kernels

A quick note about Anbernic devices.  While Anbernic makes some very appealing devices, as a company they have not acted in a particularly ethical or fair way towards the open source community.  Their devices (after the RK353M) will not be emphasized here.

# Further Work

No doubt there are many things that could be done to improve this work.  Perhaps there are errors, or perhaps the system could be more efficient.

This whole repo should probably be BuildRoot external-style, rather than a fork.  

More devices!

Make a clear statement about the need to remove the built-in SPL on any eMMC's present.

Documentation improvements

- enumerate the most likely build requirements for BuildRoot.

BuildRoot updates and bug fixes should be brought into this fork as they appear and can be tested.

# BuildRoot Commands

make jebrish_[device]_[variation]_defconfig

make

make menuconfig

make savedefconfig  

make show-targets 

make [target]-menuconfig

make [target]-reconfigure

make [target]-rebuild

make [target]-dirclean

# Boot Log

Sample boot [log](README_D/boot_log.md).

# UART

The UART is a very useful tool for debugging.  Some [directions](README_D/uart.md).
