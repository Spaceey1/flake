{ pkgs, ... }:
let
iconTheme = {
	package = pkgs.mint-y-icons;
	name = "Mint-Y-Dark-Teal";
};
cursorTheme = {
	name = "phinger-cursors-light";
	package = pkgs.phinger-cursors;
	size = 24;
};
in
{
	gtk = {
		enable = true;
		inherit iconTheme;
		inherit cursorTheme;
		gtk2 = {
			inherit iconTheme;
			inherit cursorTheme;
		};
		gtk3 = {
			inherit iconTheme;
			inherit cursorTheme;
		};
		gtk4 = {
			inherit iconTheme;
			inherit cursorTheme;
		};
	};
}
