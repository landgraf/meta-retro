inherit core-image

require classes/include/retro-core-image-debug.inc
require classes/include/retro-core-image-development.inc
require classes/include/retro-core-image-raspberrypi.inc
require classes/include/retro-core-image-rauc.inc

RETRO_WAYLAND_COMPOSITOR ??= "weston"

IMAGE_INSTALL_append = " \
    ${@bb.utils.contains('DISTRO_FEATURES', 'polkit systemd', 'rtkit', '', d)} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'pulseaudio', 'pulseaudio-server', '', d)} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'retroarch-automount', 'udev-extraconf', '', d)} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'retroarch-autostart systemd', 'retroarch-service', '', d)} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'retroarch-firmware', 'firmware-libretro', '', d)} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', '${RETRO_WAYLAND_COMPOSITOR}', '', d)} \
    ${@bb.utils.filter('DISTRO_FEATURES', 'kodi rauc resize-helper polkit', d)} \
    cpupower \
    kernel-modules \
    packagegroup-libretro-cores \
    retroarch \
    retroarch-cg-shaders \
    retroarch-glsl-shaders \
    retroarch-slang-shaders \
"

IMAGE_ROOTFS_EXTRA_SPACE_append = "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', ' + 4096', '' ,d)}"
