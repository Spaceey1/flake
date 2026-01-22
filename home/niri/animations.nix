{ lib, ... }:

let
  closeShader = builtins.readFile ./shaders/close.frag;
  openShader = builtins.readFile ./shaders/open.frag;
  animationsKdl = ''
    animations {
      window-close {
        duration-ms 250
        custom-shader "${closeShader}"
      }
      window-open {
        duration-ms 250
        custom-shader "${openShader}"
      }
    }
  '';
in
{
  xdg.configFile."niri/config.kdl".text = lib.mkAfter animationsKdl;
}
