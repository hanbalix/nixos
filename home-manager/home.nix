{
  config,
  pkgs,
  inputs,
  ...
}:
#symlink for a copy of my dot files
let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/home-manager/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    nvim = "nvim";
    niri = "niri";
    noctalia = "noctalia";
    ghostty = "ghostty";
    zsh = "zsh";
    starship = "starship";
    xdg = "xdg";
    keyd = "keyd";
    tmux = "tmux";
    };

in {
  home.username = "x";
  home.homeDirectory = "/home/x";
  home.stateVersion = "25.11";

  imports = [
    inputs.noctalia.homeModules.default
    ../modules/home-manager/zsh/zsh.nix
    ../modules/home-manager/swayidle/swayidle.nix
    # ../modules/home-manager/lsp/lsp.nix
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

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  home.enableNixpkgsReleaseCheck = false;
}
