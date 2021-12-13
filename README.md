# linuxbundles

[Downloadable and runnable](https://github.com/mudler/linuxbundles/releases), standalone bundles of linux distributions built with Github actions:

- [x] Ubuntu 20.04 [src](/ubuntu-20.04)
- [x] Alpine 3.15 [src](/alpine-3.15)
- [x] ArchLinux [src](/archlinux)
- [x] Gentoo [src](/gentoo)
- [x] Debian Stretch [src](/debian-stretch)
- [x] Fedora 36 [src](/fedora-36)
- [x] openSUSE Leap 15.3 [src](/leap-15.3)
- [x] Centos 8 [src](/centos-8)
- [x] Ubuntu LXDE [src](/ubuntu-lxde-vnc)

Download the bundle in the [release](https://github.com/mudler/linuxbundles/releases) page and just run them! (no root permission required).

By default, running the bundle will open up a shell which inherits env var from your system. To spawn up a clean shell, run:

```
./<bundle name> --entrypoint /bin/sh - -c "env -i sh"
```

Built with [poco](https://github.com/mudler/poco)

# 🐜 Contribution

You can improve this project by contributing in following ways:

- report bugs
- suggest new distro to be added
- fix issues
- asking questions (just open an issue)

and any other way if not mentioned here.