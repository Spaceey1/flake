{ config, lib, ... }:
{
  config = lib.mkIf config.programs.fastfetch.enable {
    xdg.configFile."fastfetch/config.jsonc".text = ''
      	{
      	    "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
      	    "display": {
      	        "size": {
      	            "maxPrefix": "MB",
      	            "ndigits": 0
      	        }
      	    },
      	    "logo": {
      		"type":"small",
      		"color": {
      			"1":"#9342e4",
      			"2":"#5c298f"
      		}
      	
      		//"type":"kitty-direct",
      		//"source":"~/.config/fastfetch/amongus.png",
      		//"width": 20,
      		//"source":"~/.config/fastfetch/amongus.txt",
      	    },
      	    "modules": [
      	        "title",
      		{
      			"type": "custom",
      			"format": "   "
      		},
      	        "os",
      	        "wm",
      		"terminal",
      	        "cpu",
      	        {
      	            "type": "gpu",
      	            "key": "GPU"
      	        },
      		{
      			"type": "custom",
      			"format": " "
      		},
      		{
      			"type": "custom",
      			"format": "if you read this you're gay"
      		}
      	    ]
      	}
      	'';
  };

}
