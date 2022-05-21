Archlinux Theme for SDDM
------------------------
SDDM is a Login Manager for Linux which can be themed by qml. This is a port of existing kdm themes (package archlinux-themes-kdm) to SDDM.

The Theme is available through AUR: 
* archlinux-themes-sddm
* https://aur.archlinux.org/packages/archlinux-themes-sddm/

![archlinux-simplyblack](https://raw.githubusercontent.com/Guidobelix/archlinux-themes-sddm/master/archlinux-simplyblack/screenshot.png "archlinux-simplyblack") ![archlinux-soft-grey](https://raw.githubusercontent.com/Guidobelix/archlinux-themes-sddm/master/archlinux-soft-grey/screenshot.png "archlinux-soft-grey") ![archlinux-kde](https://github.com/marco-parillo/archlinux-themes-sddm/blob/f0ba7ee9cad2ad2e73d944e4a9aece922ec2d173/archlinux-kde/screenshot.png "archlinux-kde")


Manual Installation
-------------------
* copy the folder(s) to /usr/share/sddm/themes/
```
$ sudo cp -r archlinux-simplyblack/  /usr/share/sddm/themes/
$ sudo cp -r archlinux-soft-grey/  /usr/share/sddm/themes/  
$ sudo cp -r archlinux-kde/  /usr/share/sddm/themes/

```
* change the current theme in System Settings; or (for example): 
```
$ sudo vim /etc/sddm.conf
[Theme]
Current=archlinux-kde 
```

* Have fun!
