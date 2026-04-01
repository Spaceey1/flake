{ lib
, stdenv
, fetchurl
, dpkg
, autoPatchelfHook
, makeWrapper
, alsa-lib
, at-spi2-atk
, at-spi2-core
, atk
, cairo
, cups
, dbus
, expat
, fontconfig
, freetype
, gdk-pixbuf
, glib
, gtk3
, libdrm
, libnotify
, libpulseaudio
, libsecret
, libuuid
, libxkbcommon
, mesa
, nspr
, nss
, pango
, systemd
, xorg
, wayland
, libglvnd
}:

stdenv.mkDerivation rec {
  pname = "bs-manager";
  version = "1.5.6";

  src = fetchurl {
    url = "https://github.com/Zagrios/bs-manager/releases/download/v${version}/bs-manager_${version}_amd64.deb";
    sha256 = "9b434c98f34f08cfd08210676026257b2bfce0fd748368e15aaab2f7fbd481cb";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    cairo
    cups
    dbus
    expat
    fontconfig
    freetype
    gdk-pixbuf
    glib
    gtk3
    libdrm
    libnotify
    libpulseaudio
    libsecret
    libuuid
    libxkbcommon
    mesa
    nspr
    nss
    pango
    systemd
    xorg.libX11
    xorg.libXScrnSaver
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
    xorg.libxcb
    xorg.libxkbfile
    xorg.libxshmfence
  ];

  runtimeDependencies = [
    (lib.getLib systemd)
    wayland
    libglvnd
  ];

  unpackPhase = ''
    dpkg-deb -x $src .
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r usr/* $out/
    cp -r opt $out/

    mkdir -p $out/bin
    
    if [ -f "$out/opt/BSManager/bs-manager" ]; then
      ln -s $out/opt/BSManager/bs-manager $out/bin/bs-manager
    elif [ -f "$out/opt/bs-manager/bs-manager" ]; then
      ln -s $out/opt/bs-manager/bs-manager $out/bin/bs-manager
    fi

    for desktop in $out/share/applications/*.desktop; do
      substituteInPlace "$desktop" \
        --replace "/opt/BSManager/bs-manager" "bs-manager" \
        --replace "/opt/bs-manager/bs-manager" "bs-manager"
    done

    runHook postInstall
  '';

  postFixup = ''
    wrapProgram $out/bin/bs-manager \
      --add-flags "--enable-features=UseOzonePlatform --ozone-platform-hint=auto"
  '';

  meta = with lib; {
    description = "An all-in-one tool that lets you easily manage BeatSaber versions, maps, mods, and even more";
    homepage = "https://github.com/Zagrios/bs-manager";
    license = licenses.gpl3Only;
    platforms = [ "x86_64-linux" ];
    mainProgram = "bs-manager";
  };
}
