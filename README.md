# uictl

Linux utility to manage some UI elements on [my fork](https://github.com/icanalesm/dwm) of [dwm](https://dwm.suckless.org/):

* Show desktop notifications on volume and screen/keyboard backlight change
* Update the status bar

On my setup, I manually update the status bar by pressing `MODKEY`+`Shift`+`b`. However, I want the status bar to be automatically updated on the following events:

* Change of power source
* Change of volume
* Enable/disable wifi and bluetooth

For screen/keyboard backlight, `uictl` serves as a wrapper for the commands that perform the action and it sends the desktop notification.

For volume, `uictl` serves as a wrapper for the commands that perform the action then it sends the desktop notification and updates the status bar.

For wifi/bluetooth and power source, `uictl` uses a udev rule to update the status bar.


## Requirements

`uictl` has the following dependencies:

* `pactl` ([pulseaudio](https://www.freedesktop.org/wiki/Software/PulseAudio/) utils) for volume control
* [brightctl](https://github.com/icanalesm/brightctl) for backlight control
* [tstat](https://github.com/icanalesm/tstat) for volume info and setting the status bar
* A notification server for desktop notifications


## Configuration

Configuration is done via the `config.mk`, `uictl` and `uictl_run` files.

### `config.mk`

This file is where the installation options are specified. By default, installation is done under `/usr/local`.

### `uictl`

This script is where the keyboard, screen and volume customisation takes place.

### `uictl_run`

This script sets the required environment variables when `uictl` is called from the udev rules file. The PulseAudio application is specified here (e.g., `pipewire-pulse` or `pulseaudio`).


## Installation

```
git clone https://github.com/icanalesm/uictl.git
cd uictl
```

Set the configuration in `config.mk`, `uictl` and `uictl_run`.

Install
```
sudo make install
```


## Acknowledgements

`uictl_run` was inspired by [Xpub](https://github.com/Ventto/xpub).
