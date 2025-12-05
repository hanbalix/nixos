{ config, pkgs, ... }:
#symlink for a copy of my dot files
let
    dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/home-manager-config";
    create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in {
    home.username = "x";
    home.homeDirectory = "/home/x";
    home.stateVersion = "25.11";

    imports = [
    ./config/noctalia/noctalia.nix
    #other noctalia settings
    #zoxide
    # niri
    # zsh.nix
    # inputs.agenix.homeManagerModules.default - this style come here
    ];

    #set git profile
    programs.git = {
    enable = true;
    settings.user = {
    name = "hanbali";
    email = "x@hanbalix.com";
  };
};


    #idk what this does
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


    # Clipboard Manager - niri
    services.cliphist = {
      enable = true;
      allowImages = true;
    };


   dconf = {
   settings."org/gnome/desktop/interface" = {
       color-scheme = "prefer-dark";
    };
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
#	wl-clipboard

	# File Managers
	kdePackages.dolphin

	#niri
	fuzzel
	swaybg
	swaylock
  	xwayland-satellite
	gpu-screen-recorder
	wlsunset
	cava
#	ddcutil #desktop only

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
	polkit_gnome

 	# Media & Applications
	mpv
	brave
	firefox
  	qview
];
    #need to activate it from config, defines per-user configs
    #programs.home-manager.enable = true;

  #
  # services.flatpak = {
  #   enable = true;
  #   remotes = [
  #     {
  #       name = "flathub";
  #       location = "https://flathub.org/repo/flathub.flatpakrepo";
  #       # user = true; # optional,HM module installs per-user by design
  #     }
  #   ];
  #
  #   packages = [
  #     # examples
  #     "com.github.tschx84.Flatseal"
  #     "org.kde.okular"
  #     "org.standardnotes.standardnotes"
  #     "dev.zed.Zed"
  #   ];
  #   };
  #   #uninstallUnmanaged = true; # optional: prunes user flatpaks not in `packages`

}

