LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

inherit libretro

SRCREV = "${AUTOREV}"
SRC_URI = "gitsm://github.com/libretro/dosbox-libretro.git;protocol=https"
S = "${WORKDIR}/git"

LIBRETRO_CORE = "dosbox"
LIBRETRO_PLATFORM = "unix"

LIBRETRO_REPRESENT_X86_64_AS = "x86_64"
