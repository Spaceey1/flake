{
  fetchzip,
  stdenv,
  openssl_3_5,
  alsa-lib,
  autoPatchelfHook,
  wayland,
  libxkbcommon,
  libGL,
  lib,
  makeWrapper,
  makeDesktopItem,
  copyDesktopItems,
}:
let
  version = "v1.6.2";
in
stdenv.mkDerivation {
  pname = "noita-proxy";
  inherit version;
  src = fetchzip {
    url = "https://github.com/IntQuant/noita_entangled_worlds/releases/download/${version}/noita-proxy-linux.zip";
    sha256 = "sha256-08+W4uGTzVrnX4tsnoLFwvEuLPozdJbKAJZQJoqjXBA=";
    stripRoot = false;
  };
  nativeBuildInputs = [
    autoPatchelfHook
    stdenv.cc.cc.lib
    makeWrapper
    copyDesktopItems
  ];
  buildInputs = [
    openssl_3_5
    alsa-lib
    wayland
    libxkbcommon
    libGL
  ];
  runtimeDependencies = [
    (placeholder "out")
  ];
  installPhase = ''
    runHook preInstall
    mkdir -p $out
    install -Dm755 noita_proxy.x86_64 $out/bin/noita_proxy
    install libsteam_api.so $out/bin/libsteam_api.so
    runHook postInstall
  '';
  postFixup = ''
    wrapProgram $out/bin/noita_proxy \
      --prefix LD_LIBRARY_PATH : ${
        lib.makeLibraryPath [
          wayland
          libxkbcommon
          libGL
        ]
      }
  ''
  + (lib.optionalString (stdenv.isLinux) ''
    ln -s ${wayland}/lib/libwayland-client.so.0 $out/bin/libwayland-client.so || true
  '');
  desktopItems = [
    (makeDesktopItem {
      exec = "noita_proxy";
      desktopName = "Noita proxy";
      name = "noita_proxy";
    })
  ];
}
