{ config, pkgs, ... }:

let
    dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
    create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in {
    home.username = "x";
    home.homeDirectory = "/home/x";
    home.stateVersion = "25.11";


    programs.git = {
      enable = true;
      userName = "hanbali";
      userEmail = "x@hanbalix.com";
    };

    programs.zsh = {
        enable = true;
        initExtra = ''
            export PS1='\[\e[38;5;75m\]\u@\h \[\e[38;5;113m\]\w \[\e[38;5;189m\]\$ \[\e[0m\]'
        '';
    };

    xdg.configFile."nvim" = {
        source = create_symlink "${dotfiles}/nvim/";
        recursive = true;
    };

    home.packages = with pkgs; [
        neovim
        ripgrep
        nil
        gcc
        nixpkgs-fmt
        nodejs
        go
        gopls
    ];
}

