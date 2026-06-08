# dwmui

Linux utility to manage some UI elements on [my fork of dwm](https://github.com/icanalesm/dwm):

* The status bar is updated manually with `MODKEY`+`Shift`+`b`. However, I want the bar to be automatically updated on the following events:

    * Change of power source (battery to AC and viceversa)
    * Change of volume
    * Enable/disable wifi and bluetooth

* Show notifications on volume and screen/keyboard backlight change

For power source and wifi/bluetooth, dwmui uses udev rules to update the status bar.

For volume, dwm calls dwmui to update the status bar and show an on-screen display (desktop notification).

For screen/keyboard backlight, dwm calls dwmui to send an on-screen display (desktop notification).


## Requirements

dwmui has the following dependencies:

* [dwmblocks-async](https://github.com/UtkarshVerma/dwmblocks-async) as status bar
* [brightnessctl](https://github.com/Hummer12007/brightnessctl) for backlight information
* [`wpctl`](https://pipewire.pages.freedesktop.org/wireplumber/tools/wpctl.html)([wireplumber](https://pipewire.pages.freedesktop.org/wireplumber)) for volume information
* A notification server for desktop notifications


## Design

dwmui consists of components and an administration script. The components are different scripts which provide information and actions on different components of the system (backlight, volume, etc.); these scripts are named `dwmui-<component>`. The administration script `dwmui-adm` is the interface between dwmui and other parts of the system. Whenever a UI element needs to be shown or updated (status bar or on-screen display), `dwmui-adm` must be called and the caller must pass the component and device name as parameters. Internally, `dwmui-adm` calls the different component scripts to show/update the relevant UI elements.

### udev rules

dwmui can be called from udev rules to show/update UI elements when certain events are triggered. The `RUN` key is used to call `dwmui-adm` (passing the component and device name as parameters). For example, the following rule matches (with the `KERNEL` key) a battery with name `BAT0`:
```
ACTION=="change", SUBSYSTEM=="power_supply", KERNEL=="BAT0" RUN+="/usr/local/bin/dwmui-adm battery %k"
```
and the following rule matches (with the `ATTR{name}` key) a wifi device with name `phy0`:
```
ACTION=="change", SUBSYSTEM=="rfkill", ATTR{name}=="phy0", RUN+="/usr/local/bin/dwmui-adm rfkill %s{name}"
```

See `udev(7)` for information about udev rules.

### Status bar

The status bar ([dwmblocks-async](https://github.com/UtkarshVerma/dwmblocks-async)) directly calls the component scripts to obtain the information to show. The bar is updated calling `dwmui-adm` with the corresponding component and device, `dwmui-adm` then sends the [corresponding signal](https://github.com/UtkarshVerma/dwmblocks-async?tab=readme-ov-file#signalling-changes). The call to `dwmui-adm` can be done, for example, via udev rules as above or as part of a keybind in dwm.


## Configuration

Configuration is done via the `config.mk`, `dwmui-adm` and `99-dwmui.rules` files.

### `config.mk`

This file is where the installation options are specified. By default, installation is done under `/usr/local`.

### `dwmui-adm`

The `signal_dwmblocks` function sends dwmblocks-async the signal to update the corresponding block. This function must be configured to match the device with the signal specified in the [configuration of dwmblocks-async](dwmblocks-async/config.h).

### `99-dwmui.rules`

Configure here the rules to match devices whose status is to be displayed. Use the `RUN` key to call `dwmui-adm` (passing the component and device name as parameters)


## Installation

```
git clone https://github.com/icanalesm/dwmui.git
cd dwmui
```
Set the desired configuration, then install
```
sudo make install
```
