{ pkgs, ... }:

{
	home.file.".local/share/icons/default" = {
		source = "${pkgs.phinger-cursors}/share/icons/phinger-cursors-light/";
		recursive = true;
	};
}
