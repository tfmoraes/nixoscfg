{ appimageTools, lib, fetchurl, gtk3, gsettings-desktop-schemas, makeDesktopItem, pkgs}:

let
  pname = "zettlr";
  version = "1.7.5";
  name = "${pname}-${version}";
  appimageContents = appimageTools.extractType2 {
    inherit name src;
  };
  src = fetchurl {
    url = "https://github.com/Zettlr/Zettlr/releases/download/v${version}/Zettlr-${version}-x86_64.appimage";
    sha256 = "040lx01ywdpla34d4abkmh51kchr11s17la6fk6yq77y8zb87xzi";
  };
  need_pkgs = pkgs: with pkgs; [
    desktop-file-utils
    xorg.libXcomposite
    xorg.libXtst
    xorg.libXrandr
    xorg.libXext
    xorg.libX11
    xorg.libXfixes
    libGL

    gst_all_1.gstreamer
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-plugins-base
    libdrm
    xorg.xkeyboardconfig
    xorg.libpciaccess

    glib
    gtk2
    bzip2
    zlib
    gdk-pixbuf

    xorg.libXinerama
    xorg.libXdamage
    xorg.libXcursor
    xorg.libXrender
    xorg.libXScrnSaver
    xorg.libXxf86vm
    xorg.libXi
    xorg.libSM
    xorg.libICE
    gnome2.GConf
    freetype
    (curl.override { gnutlsSupport = true; sslSupport = false; })
    nspr
    nss
    fontconfig
    cairo
    pango
    expat
    dbus
    cups
    libcap
    SDL2
    libusb1
    udev
    dbus-glib
    libav
    atk
    at-spi2-atk
    libudev0-shim
    networkmanager098

    xorg.libXt
    xorg.libXmu
    xorg.libxcb
    xorg.xcbutil
    xorg.xcbutilwm
    xorg.xcbutilimage
    xorg.xcbutilkeysyms
    xorg.xcbutilrenderutil
    libGLU
    libuuid
    libogg
    libvorbis
    SDL
    SDL2_image
    glew110
    openssl
    libidn
    tbb
    wayland
    mesa
    libxkbcommon

    flac
    freeglut
    libjpeg
    libpng12
    libsamplerate
    libmikmod
    libtheora
    libtiff
    pixman
    speex
    SDL_image
    SDL_ttf
    SDL_mixer
    SDL2_ttf
    SDL2_mixer
    gstreamer
    libappindicator-gtk2
    libcaca
    libcanberra
    libgcrypt
    libvpx
    librsvg
    xorg.libXft
    libvdpau
    alsaLib

    harfbuzz
    e2fsprogs
    libgpgerror
    keyutils.lib
    libjack2
    fribidi
    p11-kit

      # libraries not on the upstream include list, but nevertheless expected
      # by at least one appimage
      libtool.lib # for Synfigstudio
      at-spi2-core
    ];
in appimageTools.wrapType2 rec {

  inherit name src;

  profile = ''
    export XDG_DATA_DIRS=${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}:${gtk3}/share/gsettings-schemas/${gtk3.name}:$XDG_DATA_DIRS
  '';

  multiPkgs = null; # no 32bit needed
  extraPkgs = appimageTools.defaultFhsEnvArgs.multiPkgs;
  extraInstallCommands = ''
    mv $out/bin/{${name},${pname}}
    install -m 444 -D ${appimageContents}/zettlr.desktop $out/share/applications/zettlr.desktop
    install -m 444 -D ${appimageContents}/zettlr.png $out/share/icons/hicolor/512x512/apps/zettlr.png
    substituteInPlace $out/share/applications/zettlr.desktop --replace 'Exec=AppRun' 'Exec=${pname}'
  '';

  meta = with lib; {
    description = "A markdown editor for writing academic texts and taking notes";
    homepage = "https://www.zettlr.com";
    platforms = [ "x86_64-linux" ];
    license = licenses.gpl3;
  };
}
