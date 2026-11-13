{ pkgs }:

pkgs.buildFHSEnv {
  name = "rider-fhs";

  targetPkgs = p: with p; [
    # базовое
    stdenv.cc.cc.lib
    zlib
    openssl
    icu
    krb5
    curl
    libsecret
    fontconfig
    freetype
    glib
    gtk3
    dbus
    xdg-utils
    git
    openssh

    # встроенный браузер (JCEF), звук, графика
    nss
    nspr
    atk
    at-spi2-atk
    cups
    libdrm
    libgbm
    mesa
    libGL
    alsa-lib
    pango
    cairo
    expat
    libxkbcommon
    wayland

    # X11 (в свежем nixpkgs xorg.* могут быть переименованы: libx11, libxext и т.д.)
    libX11
    libXext
    libXrender
    libXtst
    libXi
    libXrandr
    libXcursor
    libXfixes
    libXcomposite
    libXdamage
    libxcb
    libXScrnSaver

    # опционально, если нужны dotnet-проекты вне Unity
    # dotnet-sdk
  ];

  runScript = pkgs.writeShellScript "rider-run" ''
    RIDER_HOME="''${RIDER_HOME:-$HOME/opt/rider}"
    # отладка: RIDER_FHS_DEBUG=1 rider-fhs → шелл внутри окружения
    if [ -n "$RIDER_FHS_DEBUG" ]; then exec bash; fi
    exec "$RIDER_HOME/bin/rider.sh" "$@"
  '';

  # ВАЖНО: не включайте unsharePid / unshareIpc / privateTmp.
  # Rider проверяет PID запущенного Unity и общается с ним через общие сокеты.
}
