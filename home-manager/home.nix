{ config, pkgs, inputs,  ... }:
#symlink for a copy of my dot files
let
    dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/home-manager/config";
    create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in {
    home.username = "x";
    home.homeDirectory = "/home/x";
    home.stateVersion = "25.11";

    imports = [
        inputs.noctalia.homeModules.default 
    ];

    programs.noctalia-shell = {
        enable = true;
        systemd.enable = true;
        };
    programs.git = {
    enable = true;
    settings.user = {
    name = "hanbali";
    email = "x@hanbalix.com";
  };
};
    programs.zsh = {
        enable = true;
        initContent = ''
        '';
    };
    #enables my .dotfiles to easily update,
    xdg.configFile."nvim" = {
        source = create_symlink "${dotfiles}/nvim/";
        recursive = true;
    };

    xdg.configFile."noctalia" = {
        source = create_symlink "${dotfiles}/noctalia/";
        recursive = true;
    };
    xdg.configFile."niri" = {
        source = create_symlink "${dotfiles}/niri/";
        recursive = true;
    };
    xdg.configFile."keyd" = {
        source = create_symlink "${dotfiles}/keyd/";
    };

      dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
  };

    # Clipboard Manager - niri
    services.cliphist = {
      enable = true;
      allowImages = true;
    };

    home.packages = with pkgs; [
    alacritty
	ghostty
	distrobox
    #nvim +dependencies
    neovim
    ripgrep
    nil
    gcc
    nodejs
	nixpkgs-fmt
	go
	gopls
	python3
  	# Terminal & Shell Tools
  	htop
 	jq
	zoxide
	starship
	bat
	fastfetch
	nerdfetch
	yazi
	tmux
	eza
	fd
	tree
	#niri
	fuzzel
	swaybg
	swaylock
  	xwayland-satellite
	gpu-screen-recorder
	wlsunset
	cava
#	ddcutil for niri(desktop only)
	# Theme & Style Configuration
  	kdePackages.qt6ct
  	pkgs.libsForQt5.qt5ct
  	kdePackages.breeze
  	kdePackages.breeze-gtk
  	kdePackages.systemsettings
  	# Audio Control
  	pavucontrol
  	pulseaudio
  	playerctl
  	# System Utilities
  	networkmanagerapplet
	pkgs.unzip
 	# Media & Applications
	mpv
	brave
	firefox
  	qview
    tree
    ];




}

