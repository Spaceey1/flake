{
  stdenv,
  fetchzip,
  autoPatchelfHook,
  udev,
  dbus,
}:
stdenv.mkDerivation rec {
  pname = "vr-lighthouse";
  version = "1.4.0";
  src = fetchzip {
    url = "https://github.com/ShayBox/Lighthouse/releases/download/${version}/Linux-x86_64.zip";
    sha256 = "sha256-ZseNwoU++R1LmGIfyCGwLADG4TC4mnpQju0JafrMAWY=";
    stripRoot = false;
  };
  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [
    udev
    dbus
    stdenv.cc.cc.lib
  ];
  installPhase = ''
    runHook preInstall
    install -Dm755 lighthouse $out/bin/lighthouse
    runHook postInstall
  '';
}
