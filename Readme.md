Archlinux Theme for SDDM
------------------------
SDDM is a Login Manager for Linux which can be themed by qml. This is a port of existing kdm themes (package archlinux-themes-kdm) to SDDM.

The Theme is available through AUR: 
* archlinux-themes-sddm
* https://aur.archlinux.org/packages/archlinux-themes-sddm/

![archlinux-simplyblack](https://raw.githubusercontent.com/Guidobelix/archlinux-themes-sddm/master/archlinux-simplyblack/screenshot.png "archlinux-simplyblack") ![archlinux-soft-grey](https://raw.githubusercontent.com/Guidobelix/archlinux-themes-sddm/master/archlinux-soft-grey/screenshot.png "archlinux-soft-grey")

Manual Installation
-------------------
* copy the two folders (archlinux-simplyblack and archlinux-soft-grey) to /usr/share/sddm/themes/
```
$ sudo cp -r archlinux-simplyblack/  /usr/share/sddm/themes/
$ sudo cp -r archlinux-soft-grey/  /usr/share/sddm/themes/    
```
* change the current Theme to archlinux-simplyblack or archlinux-soft-grey in /etc/sddm.conf (sudo required)
```
[Theme]
Current=archlinux-soft-grey 
```

* Have fun!
