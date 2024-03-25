# { lib
# , stdenv
# , fetchzip
# , autoPatchelfHook
# , makeWrapper
# , xkeyboard_config
# , unzip
# , libGL
# , glib
# , fontconfig
# , dbus
# }:

# # pkgname=binaryninja-free
# # _pkgname=binaryninja
# # pkgver=4.0.4911
# # pkgrel=1
# # pkgdesc="An interactive decompiler, disassembler, debugger, and binary analysis platform."
# # arch=('x86_64')
# # url="https://binary.ninja"
# # license=('custom:Binary Ninja Free Edition License Agreement')
# # depends=('python' 'glibc' 'qt5-base')
# # makedepends=()
# # optdepends=()
# # source=(
# # 	"https://cdn.binary.ninja/installers/BinaryNinja-free.zip"
# # 	"${pkgname}.png"
# # 	"${pkgname}.desktop"
# # )
# # sha256sums=(
# # 	'c692c160f4fc3b47c7b82cb2a0a0b6f6ee21a878ea6a9ceaf9e8e3cf1b09522d'
# # 	'4f318001e7d39279ce063ef42077bae03e95c112aa203a4be3ea3d913c34327e'
# # 	'075158d0131dd89565e021a6854a6ae0237442e0b4e03a61638a7f8a69ec9f85'
# # )

# # package() {
# # 	install -d "${pkgdir}/opt/${pkgname}"
# # 	install -d "${pkgdir}"/usr/share/{icons,applications}

# # 	cp -r "${srcdir}/${_pkgname}"/* "${pkgdir}/opt/${pkgname}/"
# # 	install "${srcdir}/${pkgname}.png" "${pkgdir}/usr/share/icons/"
# # 	install "${srcdir}/${pkgname}.desktop" "${pkgdir}/usr/share/applications/"
# # }

# stdenv.mkDerivation rec {
#   pname = "binaryninja-wayland";
#   version = "1.0.0";

#   buildInputs = [
#     autoPatchelfHook
#     makeWrapper
#     unzip
#     libGL
#     stdenv.cc.cc.lib
#     glib
#     fontconfig
#     dbus
#   ];

#   src = fetchzip {
#     # see https://binary.ninja/js/hashes.js
#     url = "https://cdn.binary.ninja/installers/BinaryNinja-free.zip";
#     hash = "sha256-R5v7jeT1GNnQG1gm34L66JqdmcRs/7ywVLGIemc7VvE=";
#   };

#   buildPhase = ":";
#   installPhase = ''
#     mkdir -p $out/bin
#     mkdir -p $out/opt
#     cp -r * $out/opt
#     chmod +x $out/opt/binaryninja
#     makeWrapper $out/opt/binaryninja \
#           $out/bin/binaryninja \
#           --prefix "QT_XKB_CONFIG_ROOT" ":" "${xkeyboard_config}/share/X11/xkb"
#   '';

# }

{ stdenv
, fetchzip
, autoPatchelfHook
, makeWrapper
, unzip
, requireFile
, python311
, libGL
, zlib
, xcbutilwm
, xcbutilimage
, xcbutilkeysyms
, xcbutilrenderutil
, libxkbcommon
, freetype
, fontconfig
, wayland-scanner
, dbus
, ...
}:

stdenv.mkDerivation {
  name = "binaryninja";

  # src = requireFile {
  #   name = "BinaryNinja-dev.zip";
  #   url = "https://binary.ninja";
  #   sha256 = "1275c20iy4alfxrqwk0c3vqc92gv894sxc23niksgpxzbxj6pc03";
  # };

  src = fetchzip {
    # see https://binary.ninja/js/hashes.js
    url = "https://cdn.binary.ninja/installers/BinaryNinja-free.zip";
    hash = "sha256-R5v7jeT1GNnQG1gm34L66JqdmcRs/7ywVLGIemc7VvE=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
    unzip
    dbus
  ];

  prePatch = ''
    addAutoPatchelfSearchPath $out/opt
  '';

  # error: auto-patchelf could not satisfy dependency libGL.so.1
  # error: auto-patchelf could not satisfy dependency libz.so.1
  # error: auto-patchelf could not satisfy dependency libfreetype.so.6
  buildInputs = [
    dbus
    libGL # libGL.so.1
    stdenv.cc.cc.lib # libstdc++.so.6
    zlib # libz.so.1
    xcbutilwm # libxcb-icccm.so.4
    xcbutilimage # libxcb-image.so.4
    xcbutilkeysyms # libxcb-keysyms.so.1
    xcbutilrenderutil # libxcb-render-util.so.0
    libxkbcommon # libxkbcommon.so.0
    freetype # libfreetype.so.6
    fontconfig.lib
    wayland-scanner.out
    (python311.withPackages (ps:
      with ps; [
        ipython
        ipdb
        pip
      ]
    ))
  ];

  autoPatchelfIgnoreMissingDeps = [
    "libQt6Qml.so.6"
    "libQt6Widgets.so.6"
    "libQt6PrintSupport.so.6"
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/opt
    cp -r * $out/opt
    chmod +x $out/opt/binaryninja

    # Symlink python for binja to use
    ln -s ${python311}/lib/libpython3.11.so.1.0 $out/opt/

    # Make the wrapper for the binja binary
    mkdir -p $out/bin
    makeWrapper $out/opt/binaryninja $out/bin/binaryninja

    runHook postInstall
  '';

  meta = {
    platforms = [ "x86_64-linux" ];
  };
}
