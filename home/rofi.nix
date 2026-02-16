{ pkgs, lib, config, ... }:

{
  programs.rofi = lib.mkIf config.programs.rofi.enable {
    plugins = [
      pkgs.rofi-emoji
    ];
    package = pkgs.rofi;
  };

  xdg.configFile."rofi/config.rasi".text = ''
    	configuration {
    		drun-match-fields: "name";
    		tokenize: false;
    		timeout {
    			action: "kb-cancel";
    			delay:  0;
    		}
    		filebrowser {
    			directories-first: true;
    			sorting-method:    "name";
    		}
    		combi {
    			modi: "window,drun";
    		}
    		drun {
    			match-fields: "name";
    		}
    	}
    	@theme "theme.rasi"
    	'';
  xdg.configFile."rofi/theme.rasi".text = ''
    	*{
    	    background-color: #00000000;
    	    text-color: #FFFFFF;
    	}
    	window {
    	    width: 15% ;
    	    height: 45%;
    	    location: east;
    	    border: 0px;
    	    x-offset: -50px;
    	    border-radius: 10px;
    	    border: 1px;
    	    border-color: #009999;
    	}
    	
    	inputbar {
    	    padding: 4px;
    	    background-color: #002b33;
    	    border: 0px;
    	}
    	
    	mainbox {
    	    background-color: #000000;
    	    expand: true;
    	}
    	
    	listview {
    	    dynamic: false;
    	    lines: 0;
    	}
    	
    	element {
    	    children: [element-icon, element-text];
    	}
    	
    	element selected{
    	    background-color: #354669;
    	}
    	
    	error-message {
    	    padding: 1.0000em ;
    	    background-color: #100000;
    	    expand: true;
    	    border-color: DarkRed;
    	    border: 2px ;
    	    border-radius: 10px;
    	}
    	
    	prompt{
    	    enabled: false;
    	}
    	'';
}
