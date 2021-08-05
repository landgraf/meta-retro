SUMMARY  = "The SPIR-V Tools project provides an API and commands for \
processing SPIR-V modules"
DESCRIPTION = "The project includes an assembler, binary module parser, \
disassembler, validator, and optimizer for SPIR-V."
LICENSE  = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"
SECTION = "graphics"

S = "${WORKDIR}/git"
DEST_DIR = "${S}/external" 
SRC_URI = "git://github.com/KhronosGroup/SPIRV-Tools.git;name=spirv-tools \
           git://github.com/KhronosGroup/SPIRV-Headers.git;name=spirv-headers;destsuffix=${DEST_DIR}/spirv-headers \
           git://github.com/google/effcee.git;name=effcee;destsuffix=${DEST_DIR}/effcee \
           git://github.com/google/re2.git;name=re2;destsuffix=${DEST_DIR}/re2 \
           git://github.com/google/googletest.git;name=googletest;destsuffix=${DEST_DIR}/googletest \
           file://0001-Respect-CMAKE_INSTALL_LIBDIR-in-installed-CMake-file.patch;destsuffix=${DEST_DIR}/effcee \
"

PV = "2021.1"

SRCREV:spirv-tools = "b27b1afd12d05bf238ac7368bb49de73cd620a8e"
SRCREV:spirv-headers = "f027d53ded7e230e008d37c8b47ede7cd308e19d"
SRCREV:effcee = "cd25ec17e9382f99a895b9ef53ff3c277464d07d"
SRCREV:re2 = "5bd613749fd530b576b890283bfb6bc6ea6246cb"
SRCREV:googletest = "f2fb48c3b3d79a75a88a99fba6576b25d42ec528"

inherit cmake python3native

EXTRA_OECMAKE += "-DSPIRV_WERROR=OFF"

do_install:append() {
	install -d ${D}/${includedir}/spirv
	install -m 0644 ${DEST_DIR}/spirv-headers/include/spirv/1.2/* ${D}${includedir}/spirv
	install -d ${D}/${includedir}/spirv/unified1
	install -m 0644 ${DEST_DIR}/spirv-headers/include/spirv/unified1/* ${D}${includedir}/spirv/unified1
}

FILES_SOLIBSDEV = ""
FILES:${PN} += "${libdir}/*.so"

BBCLASSEXTEND = "native nativesdk"
