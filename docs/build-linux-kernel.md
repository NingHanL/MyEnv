## Where do I find the kernel?

[kernel org](https://git.kernel.org/)

## What tools do I need?

```sh
sudo apt-get install libncurses5-dev gcc make git exuberant-ctags bc libssl-dev

sudo yum install gcc make git ctags ncurses-devel openssl-devel

sudo zypper in git gcc ncurses-devel libopenssl-devel ctags cscope
```

## Setting up your kernel configuration

#### Duplicating your current config

If you're trying to see if a bug is fixed, you probably want to duplicate the configuration on your running kernel. That config file is stored somewhere in /boot/. There might be several files that start with config, so you want the one associated with your running kernel. You can find that by running uname -a and finding the config file that ends with your kernel version number. Copy that file into the source directory as .config. Or just run this command:

```sh
cp /boot/config-`uname -r`* .config
```

#### Making the default config

Remember, a default config may not have the options you are currently using. Run

```sh
make defconfig
```

#### Making a minimal config

Compiling a kernel from scratch from a distribution configuration can take "forever" because the distros turn on every hardware configuration possible. For people wanting to do kernel development fast, you want to make a minimal configuration. Steve Rostedt uses ktest.pl make_min_config to get a truely minimum config, but it will take a day or two to build. Warning: make sure you have all your USB devices plugged into the system, or you won't get the drivers for them!

#### Changing your config

If you need to make any changes to your configuration, you can run one of the following commands. These require the curses tools to be installed.

```sh
make menuconfig
```

or

```sh
make nconfig
```

## Building the kernel

run

```sh
make
```

Or, if you have a multi-core processor, run

```sh
make -jX
```

Where X is a number like 2 or 4. If you have a dual core, 2 or 3 might be good. Quad core, 4 or 6. Do not run with really big numbers unless you want your machine to be dog-slow!

#### Installing the kernel

To install a kernel, you will need to either manually update your GRUB configuration file, or have an installkernel script. This script installs the kernel to /boot/, installs modules to /lib/modules/X.Y.Z/ (where X.Y.Z is something like 3.1.5), and updates file /boot/grub/grub.conf. Fortunately, Ubuntu provides an installkernel script in /sbin/installkernel. The grubby RPM provides it for RPM based systems.

If you have an installkernel script, you can just run

``sh
sudo make modules_install install
```

Or, if you don't have sudo installed, run

```sh
su -c "make modules_install install"
```

#### Running your kernel

First, make sure you know how to select a kernel at boot time. If your new kernel is broken, you want a way to boot into your old kernel. The grub bootloader usually presents users with a choice of kernels and you can reboot into a known good kernel if your new compile doesn't work. Some distros use a default grub config that hides that menu. You can usually get the menu to appear by mashing the ESC key during boot after the BIOS display disappears.

Ubuntu: To make the grub menu always appear on boot under Ubuntu, remove the GRUB_HIDDEN_TIMEOUT_QUIET line from /etc/default/grub. You may want to increase the GRUB_DEFAULT timeout from 0 to 15 seconds or more. After you've finished editing the grub file you may need to update your grub file.

```sh
sudo update-grub2
```

You will (usually) need to reboot into your new kernel.
