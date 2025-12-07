{ config, pkgs, inputs, ... }:
#symlink for a copy of my dot files
let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/home-manager/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in
{
  home.username = "x";
  home.homeDirectory = "/home/x";
  home.stateVersion = "25.11";

  imports = [
    inputs.noctalia.homeModules.default
    ../modules/home-manager/zsh/zsh.nix
    ../modules/home-manager/swayidle/swayidle.nix
    ../modules/home-manager/lsp/lsp.nix

  ];
  #nvim recognize lsps
  # home.sessionVariables.PATH = "/etc/profiles/per-user/x/bin:$PATH";

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
  # programs.starship.enable = true;
  # programs.zsh = {
  # enable = false;
  # };
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

  xdg.configFile."zsh" = {
    source = create_symlink "${dotfiles}/zsh/";
  };
  xdg.configFile."starship" = {
    source = create_symlink "${dotfiles}/starship/";
  };
  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
  };

  # Clipboard Manager - niri
  services.cliphist = {
    enable = true;
    allowImages = true;
  };
  programs.swaylock = {
    enable = true;
    settings = {
      image = "/home/x/assets/wallpapers/bay.jpeg";
    };
  };
  # services.swayidle = {
  # enable = true;
  # timeouts = [
  # { timeout = 300; command = "${config.programs.swaylock.package}/bin/swaylock -f"; }
  # { timeout = 600; command = "swaymsg 'output * dpms off'"; resumeCommand = "swaymsg 'output * dpms on'"; }
  # ];
  # events = {
  # before-sleep = "${config.programs.swaylock.package}/bin/swaylock -f";
  # };
  # systemdTarget = "wayland-session.target";  # For Niri
  # };


  home.packages = with pkgs; [
    alacritty
    ghostty
    distrobox
    podman
    #nvim +dependencies
    neovim
    ripgrep
    # gcc
    nodejs
    go
    # gopls
    python3
    rustc
    cargo
    nixpkgs-fmt
    # Terminal & Shell Tools
    htop
    jq
    zoxide
    starship
    bat
    tldr
    fastfetch
    nerdfetch
    # uwufetch

    pfetch
    yazi
    tmux
    eza
    fd
    tree
    tldr
    #niri
    fuzzel
    swaybg
    swaylock
    xwayland-satellite
    gpu-screen-recorder
    wlsunset
    brightnessctl
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
    zip
    unzip
    # Media & Applications
    mpv
    brave
    firefox
    qview
    tree
  ];




  home.enableNixpkgsReleaseCheck = false;
}

