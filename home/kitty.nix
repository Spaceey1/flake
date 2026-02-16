{
  pkgs,
  lib,
  config,
  ...
}:
let
  colors = import ../colors.nix;
in
{
  options.programs.kitty = {
    nemoOpen = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.programs.kitty.enable {
    xdg.configFile."kitty/kitty.conf".text = ''
      		#background_opacity 0.90
      		background_opacity 1
      		background ${colors.palette.background.hex}

      		tab_bar_min_tabs 1
      		tab_bar_style powerline
      		tab_bar_margin_color #000000
      		tab_title_template "{index}: {title}"
      		active_tab_title_template "{fmt.bold}{fmt.fg.blue}{index}:{title}{fmt.fg.tab}"
      		confirm_os_window_close 0
      		enable_audio_bell no
      		cursor_trail 3
      		cursor_shape beam
      		mouse_hide_wait 0

      		clear_all_shortcuts yes
      		map ctrl+w close_tab
      		map ctrl+tab next_tab
      		map ctrl+shift+tab previous_tab
      		map ctrl+t new_tab_with_cwd
      		map super+shift+return launch --cwd=current --type=os-window
      		font_family Caskaydia Mono
      		map ctrl+shift+v paste_from_clipboard
      		map ctrl+shift+c copy_to_clipboard
      	''+
      (if config.programs.kitty.nemoOpen then "map super+shift+i launch --type=background --cwd=current ${pkgs.nemo}/bin/nemo ." else "");
  };
}
