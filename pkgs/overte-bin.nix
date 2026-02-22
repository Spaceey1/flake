{
  appimageTools,
  writeShellScriptBin,
  symlinkJoin,
  makeDesktopItem,
}:
let
  version = "2025.12.1";
  filename = "Overte-${version}-x86_64.AppImage";
  pname = "overte-bin";
  desktopEntry = {
    icon = "overte";
    categories = [
      "Network"
      "Game"
    ];
  };
  appImage = appimageTools.wrapType2 {
    inherit version pname;
    src = builtins.fetchurl {
      url = "https://public.overte.org/build/overte/release/${version}/${filename}";
      sha256 = "sha256:0h09bd81s3g01076k3zkswrkkaxmvqjzdiyw83wzmmxyjka36kqm";
    };
  };
  vrLauncherEntry = makeDesktopItem (
    {
      name = "Overte desktop";
      exec = "overte-desktop";
      desktopName = "Overte (Desktop)";
    }
    // desktopEntry
  );
  desktopLauncherEntry = makeDesktopItem (
    {
      name = "Overte VR";
      exec = "overte-vr";
      desktopName = "Overte (VR)";
    }
    // desktopEntry
  );
  extraEnv = "QT_QPA_PLATFORM=xcb";
  mkLauncher =
    name: args:
    writeShellScriptBin name ''
      export ${extraEnv}
      exec ${appImage}/bin/${pname} ${args} "$@"
    '';
  vrLauncher = mkLauncher "overte-vr" "--useExperimentalXR";
  desktopLauncher = mkLauncher "overte-desktop" "";
in
symlinkJoin {
  name = "overte-wrapped";
  paths = [
    vrLauncher
    vrLauncherEntry
    desktopLauncher
    desktopLauncherEntry
    appImage
  ];
}
