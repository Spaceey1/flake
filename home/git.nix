{ pkgs, lib, config, ... }:

{
  programs.git = lib.mkIf config.programs.git.enable {
    settings = {
      user = {
        name = "Spaceey1";
        email = "bruno@gadula.ca";
      };
      init.defaultBranch = "master";
      credential.helper = "${pkgs.git.override { withLibsecret = true; }}/bin/git-credential-libsecret";
    };
  };
}
