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
    starship = "starship";
    xdg = "xdg";
    keyd = "keyd";
    tmux = "tmux";
    yazi = "yazi";
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
  home.sessionVariables.PATH = "/etc/profiles/per-user/x/bin:$PATH";

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

qt = {
    enable = true;
    platformTheme.name = "qt6ct";
    style.name = "Breeze";
  };

  home.packages = with pkgs; [
    ghostty
    distrobox
    podman
    #nvim +dependencies
    neovim
    ripgrep
    gcc
    nodejs
    go
    gopls
    python3
    python313Packages.pyqt6
    python313Packages.pillow
    rustc
    cargo
    nixpkgs-fmt
    alejandra
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
    libsForQt5.qt5ct
    kdePackages.breeze
    kdePackages.breeze-icons
    # kdePackages.breeze-gtk
    # Audio Control
    pavucontrol
    pulseaudio
    playerctl
    # System Utilities
    kdePackages.dolphin
    networkmanagerapplet
    zip
    unzip
    # Media & Applications
    mpv
    brave
    firefox
    qview
    tree
    kdePackages.okular
  ];
# home.sessionVariables.QT_ICON_THEME = "breeze";
# home.sessionVariables.QT_QPA_PLATFORMTHEME = "qt6ct";
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };
  
  xdg.mimeApps = {
    enable = true; 
    defaultApplications = {
      "image/jpeg" = [ "qview.desktop" ];
      "image/png" = [ "qview.desktop" ];
      "image/gif" = [ "qview.desktop" ];
      "image/webp" = [ "qview.desktop" ];
      "application/pdf" = [ "org.kde.okular.desktop" ];
      "application/epub+zip" = [ "org.kde.okular.desktop" ];
      "text/plain" = [ "nvim.desktop" ];
      "text/x-nix" = [ "nvim.desktop" ];
      "text/x-go" = [ "nvim.desktop" ];
      "text/x-c" = [ "nvim.desktop" ];
      "text/x-c++src" = [ "nvim.desktop" ];
      "application/json" = [ "nvim.desktop" ];
      "text/json" = [ "nvim.desktop" ];
      "text/x-lua" = [ "nvim.desktop" ];
      "text/x-python" = [ "nvim.desktop" ];
      "text/rust" = [ "nvim.desktop" ];
      "text/x-rust" = [ "nvim.desktop" ];
      "application/javascript" = [ "nvim.desktop" ];
      "text/javascript" = [ "nvim.desktop" ];
      "text/x-shellscript" = [ "nvim.desktop" ];
      "application/x-shellscript" = [ "nvim.desktop" ];
      "application/toml" = [ "nvim.desktop" ];
      "application/x-yaml" = [ "nvim.desktop" ];
      "text/markdown" = [ "nvim.desktop" ];
      "video/mp4" = [ "org.videolan.VLC.desktop" ];
      "video/mpeg" = [ "org.videolan.VLC.desktop" ];
      "audio/mpeg" = [ "org.videolan.VLC.desktop" ]; # .mp3
      "audio/flac" = [ "org.videolan.VLC.desktop" ];
      "audio/x-wav" = [ "org.videolan.VLC.desktop" ];
      "audio/mp4" = [ "org.videolan.VLC.desktop" ];
      # "inode/directory" = [ "org.kde.dolphin.desktop" ];
      "inode/directory" = [ "dolphin.desktop" ];
    };
  };
  
  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  home.enableNixpkgsReleaseCheck = false;
}

