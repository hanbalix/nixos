{ config, pkgs, ... }:
#symlink for a copy of my dot files
let
    dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
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



    # Clipboard Manager
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
        #nvim +dependencies
        neovim
        ripgrep
        nil
        gcc
        nodejs
        #development
        go
        gopls
        python3
        nixpkgs-fmt

        #CLI
        htop
        jq
        zoxide #better cd
        starship
        bat
        fastfetch
        nerdfetch
        yazi
        tmux
        eza
        fd
        yazi

        # utilities
        distrobox
        wlsunset
        gpu-screen-recorder
        mpv
        brave
        qview
        # niri
        xwayland-satellite
        wl-clipboard
        # inputs.noctalia.packages.${system}.default
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

