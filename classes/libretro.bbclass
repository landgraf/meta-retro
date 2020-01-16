# Class

inherit retroarch-overrides retroarch-paths retroarch-dist-checks

PR = "r109"

# Auto detection

LIBRETRO_PLATFORM_AUTODETECT = "unix"

LIBRETRO_PLATFORM_AUTODETECT_RPI1 ??= "rpi1"
LIBRETRO_PLATFORM_AUTODETECT_RPI2 ??= "rpi2"
LIBRETRO_PLATFORM_AUTODETECT_RPI3 ??= "rpi3"
LIBRETRO_PLATFORM_AUTODETECT_RPI4 ??= "rpi4"

LIBRETRO_PLATFORM_AUTODETECT_raspberrypi = "${LIBRETRO_PLATFORM_AUTODETECT_RPI1}"
LIBRETRO_PLATFORM_AUTODETECT_raspberrypi-cm = "${LIBRETRO_PLATFORM_AUTODETECT_RPI1}"
LIBRETRO_PLATFORM_AUTODETECT_raspberrypi0 =  "${LIBRETRO_PLATFORM_AUTODETECT_RPI1}"
LIBRETRO_PLATFORM_AUTODETECT_raspberrypi0-wifi = "${LIBRETRO_PLATFORM_AUTODETECT_RPI1}"

LIBRETRO_PLATFORM_AUTODETECT_raspberrypi2 = "${LIBRETRO_PLATFORM_AUTODETECT_RPI2}"

LIBRETRO_PLATFORM_AUTODETECT_raspberrypi-cm3 = "${LIBRETRO_PLATFORM_AUTODETECT_RPI3}"
LIBRETRO_PLATFORM_AUTODETECT_raspberrypi3 = "${LIBRETRO_PLATFORM_AUTODETECT_RPI3}"
LIBRETRO_PLATFORM_AUTODETECT_raspberrypi3-64 = "${LIBRETRO_PLATFORM_AUTODETECT_RPI3}"

LIBRETRO_PLATFORM_AUTODETECT_raspberrypi4 = "${LIBRETRO_PLATFORM_AUTODETECT_RPI4}"
LIBRETRO_PLATFORM_AUTODETECT_raspberrypi4-64 = "${LIBRETRO_PLATFORM_AUTODETECT_RPI4}"

# Core

LIBRETRO_CORE ??= ""
LIBRETRO_MAKEFILE_PREFIX ??= ""
LIBRETRO_MAKEFILE_FILENAME_OVERRIDE ??= ""

LIBRETRO_CORE_FILE = "${@os.path.basename(d.getVar('LIBRETRO_CORE', d, 1))}"

# Platform

LIBRETRO_PLATFORM ??= "unix"
LIBRETRO_EXTRA_MAKEFLAGS ??= ""

LIBRETRO_REPRESENT_AARCH64_AS ??= "arm64"
LIBRETRO_REPRESENT_ARM_AS ??= "arm"
LIBRETRO_REPRESENT_X86_64_AS ??= "x86_64"
LIBRETRO_REPRESENT_X86_AS ??= "x86"

LIBRETRO_CPU_ARCH_DETECT ??= "${TUNE_ARCH}"
LIBRETRO_CPU_ARCH_DETECT_arm64 = "${LIBRETRO_REPRESENT_AARCH64_AS}"
LIBRETRO_CPU_ARCH_DETECT_arm32 = "${LIBRETRO_REPRESENT_ARM_AS}"
LIBRETRO_CPU_ARCH_DETECT_x86 = "${LIBRETRO_REPRESENT_X86_AS}"
LIBRETRO_CPU_ARCH_DETECT_x86-64 = "${LIBRETRO_REPRESENT_X86_64_AS}"
LIBRETRO_CPU_ARCH ??= "${LIBRETRO_CPU_ARCH_DETECT}"

LIBRETRO_MAKEFILE_PLATFORM ??= "platform=${LIBRETRO_PLATFORM}"

# Flags

LIBRETRO_COMMON_CXXFLAGS ??= "-D__LIBRETRO__ -fPIC -shared"
LIBRETRO_COMMON_CFLAGS ??= "-D__LIBRETRO__ -fPIC -shared"

LIBRETRO_EXTRA_COMPILATION_FLAGS ??= ""
LIBRETRO_EXTRA_CXXFLAGS ??= ""
LIBRETRO_EXTRA_CFLAGS ??= ""
LIBRETRO_EXTRA_ASFLAGS ??= ""

LIBRETRO_MAKEFILE_ASFLAGS ??= "ASFLAGS=${LIBRETRO_EXTRA_ASFLAGS}"
LIBRETRO_MAKEFILE_CXXFLAGS ??= "CXXFLAGS=${CXXFLAGS} ${LIBRETRO_EXTRA_CXXFLAGS} ${LIBRETRO_EXTRA_COMPILATION_FLAGS} ${LIBRETRO_COMMON_CXXFLAGS}"
LIBRETRO_MAKEFILE_CFLAGS ??= "CFLAGS=${CFLAGS} ${LIBRETRO_EXTRA_CFLAGS} ${LIBRETRO_EXTRA_COMPILATION_FLAGS} ${LIBRETRO_COMMON_CFLAGS}"

# Features

LIBRETRO_MAKEFILE_HAVE_HARD_FLOAT = "ARM_FLOAT_ABI_HARD=${@bb.utils.contains('TUNE_FEATURES', 'callconvention-hard', '1', '0', d)}"
LIBRETRO_MAKEFILE_HAVE_NEON ??= "HAVE_NEON=${@bb.utils.contains('TUNE_FEATURES', 'neon', '1', '0', d)}"
LIBRETRO_MAKEFILE_LIBRETRO_CPU ??= "LIBRETRO_CPU=${LIBRETRO_CPU_ARCH}"
LIBRETRO_MAKEFILE_WITH_DYNAREC ??= "WITH_DYNAREC=${LIBRETRO_CPU_ARCH}"

LIBRETRO_MAKEFILE_ARCHITECTURE_OVERRIDES ??= " \
  ${LIBRETRO_MAKEFILE_HAVE_HARD_FLOAT} \
  ${LIBRETRO_MAKEFILE_HAVE_NEON} \
  ${LIBRETRO_MAKEFILE_LIBRETRO_CPU} \
  ${LIBRETRO_MAKEFILE_WITH_DYNAREC} \
"

LIBRETRO_MAKEFILE_FORCE_GLES ??= "FORCE_GLES=${@bb.utils.contains('DISTRO_FEATURES', 'retroarch-gles', '1', '0', d)}"
LIBRETRO_MAKEFILE_FORCE_GLES3 ??= "FORCE_GLES3=${@bb.utils.contains('DISTRO_FEATURES', 'retroarch-gles3', '1', '0', d)}"
LIBRETRO_MAKEFILE_HAVE_OPENGL ??= "HAVE_OPENGL=${@bb.utils.contains('DISTRO_FEATURES', 'retroarch-opengl', '1', '0', d)}"
LIBRETRO_MAKEFILE_HAVE_VULKAN ??= "HAVE_VULKAN=${@bb.utils.contains('DISTRO_FEATURES', 'retroarch-vulkan', '1', '0', d)}"

LIBRETRO_MAKEFILE_GRAPHICS_OVERRIDES ??= " \
  ${LIBRETRO_MAKEFILE_FORCE_GLES} \
  ${LIBRETRO_MAKEFILE_FORCE_GLES3} \
  ${LIBRETRO_MAKEFILE_HAVE_OPENGL} \
  ${LIBRETRO_MAKEFILE_HAVE_VULKAN} \
"

IS_ARM_ARCH ??= "0"
IS_ARM_ARCH_armarch = "1"

LIBRETRO_FULL_OVERRIDE_CXXFLAGS ??= "0"
LIBRETRO_FULL_OVERRIDE_CFLAGS ??= "0"
LIBRETRO_FULL_OVERRIDE_ASFLAGS ??= "0"

LIBRETRO_FINAL_MAKEFLAGS ??= " \
  "${LIBRETRO_MAKEFILE_PLATFORM}" \
  ${LIBRETRO_MAKEFILE_ARCHITECTURE_OVERRIDES} \
  ${LIBRETRO_MAKEFILE_GRAPHICS_OVERRIDES} \
  ${LIBRETRO_EXTRA_MAKEFLAGS} \
  ${@bb.utils.contains('LIBRETRO_FULL_OVERRIDE_CXXFLAGS', '1', '\"${LIBRETRO_MAKEFILE_CXXFLAGS}\"', '', d)} \
  ${@bb.utils.contains('LIBRETRO_FULL_OVERRIDE_CFLAGS', '1', '\"${LIBRETRO_MAKEFILE_CFLAGS}\"', '', d)} \
  ${@bb.utils.contains('LIBRETRO_FULL_OVERRIDE_ASFLAGS', '1', '\"${LIBRETRO_MAKEFILE_ASFLAGS}\"', '', d)} \
"

DEPENDS = " \
  ${@bb.utils.contains('DISTRO_FEATURES', 'retroarch-gles', 'virtual/egl virtual/libgles1 virtual/libgles2', '', d)} \
  ${@bb.utils.contains('DISTRO_FEATURES', 'retroarch-gles3', 'virtual/egl virtual/libgles1 virtual/libgles2', '', d)} \
  ${@bb.utils.contains('DISTRO_FEATURES', 'retroarch-opengl', 'virtual/libgl ', '', d)} \
  ${@bb.utils.contains('DISTRO_FEATURES', 'retroarch-vulkan', 'vulkan-loader', '', d)} \
"

do_compile() {
  if [[ ! -z "${LIBRETRO_MAKEFILE_PREFIX}" ]]; then
    echo "prefix changed: ${LIBRETRO_MAKEFILE_PREFIX}"
    cd ${LIBRETRO_MAKEFILE_PREFIX}
  fi

  MAKEFILE_PATH="Makefile";
  [[ -f "Makefile.libretro" ]] && MAKEFILE_PATH="Makefile.libretro"
  [[ -f "${LIBRETRO_MAKEFILE_FILENAME_OVERRIDE}" ]] && MAKEFILE_PATH="${LIBRETRO_MAKEFILE_FILENAME_OVERRIDE}"

# https://stackoverflow.com/questions/2129391/append-to-gnu-make-variables-via-command-line

  export CXX="${CXX} ${CXXFLAGS} ${LIBRETRO_EXTRA_CXXFLAGS} ${LIBRETRO_EXTRA_COMPILATION_FLAGS} ${LIBRETRO_COMMON_CXXFLAGS}"
  export CC="${CC} ${CFLAGS} ${LIBRETRO_EXTRA_CFLAGS} ${LIBRETRO_EXTRA_COMPILATION_FLAGS} ${LIBRETRO_COMMON_CFLAGS}"

  oe_runmake -f "${MAKEFILE_PATH}" ${LIBRETRO_FINAL_MAKEFLAGS} \
    CC_PREFIX=${TARGET_PREFIX} \
    CC_AS="${CC}" \
    ARCH=${LIBRETRO_CPU_ARCH} \
    ARM="${IS_ARM_ARCH}" \
    CPU_ARCH=${TUNE_ARCH} \
    LDFLAGS_END="${LDFLAGS}"
}

FILES_${PN} += "${RETROARCH_LIBRETRO_CORES_DIR}"

do_install() {
  install -d ${D}${RETROARCH_LIBRETRO_CORES_DIR}
  install -m 644 ${S}/${LIBRETRO_CORE}_libretro.so ${D}${RETROARCH_LIBRETRO_CORES_DIR}/${LIBRETRO_CORE_FILE}_libretro.so
}
