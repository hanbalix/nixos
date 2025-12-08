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
    # zsh = "zsh";
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
  
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      gopls
      nixpkgs-fmt
      ripgrep
      gcc
      clang
      rustc
      cargo
      nodejs
    ];
  }; # ← FIXED: Added closing brace and semicolon here (was missing before home.packages)

  # ← FIXED: Moved home.packages OUT of programs.neovim block (was nested inside, line 57)
  home.packages = with pkgs; [
    alacritty
    ghostty
    distrobox
    podman
    #nvim +dependencies
    # neovim
    # ripgrep
    # gcc
    # nodejs
    go
    # gopls
    python3
    # rustc
    # cargo
    # nixpkgs-fmt
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

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  # xdg.mimeApps = {
  #   enable = true;
  #
  #   defaultApplications = {
  #     # --- Images (qview) ---
  #     "image/jpeg" = [ "qview.desktop" ];
  #     "image/png" = [ "qview.desktop" ];
  #     "image/gif" = [ "qview.desktop" ];
  #     "image/webp" = [ "qview.desktop" ];
  #     "image/svg+xml" = [ "qview.desktop" ];
  #     "image/bmp" = [ "qview.desktop" ];
  #     "image/tiff" = [ "qview.desktop" ];
  #
  #     # --- Documents (Okular Flatpak) ---
  #     "application/pdf" = [ "org.kde.okular.desktop" ];
  #     "application/epub+zip" = [ "org.kde.okular.desktop" ];
  #
  #     # --- Programming & Text (Neovim) ---
  #     # General text
  #     "text/plain" = [ "nvim.desktop" ];
  #
  #     # Nix
  #     "text/x-nix" = [ "nvim.desktop" ];
  #     "application/x-nix" = [ "nvim.desktop" ]; # rarely used alternative
  #
  #     # Go
  #     "text/x-go" = [ "nvim.desktop" ];
  #
  #     # C / C++
  #     "text/x-c" = [ "nvim.desktop" ];
  #     "text/x-csrc" = [ "nvim.desktop" ];
  #     "text/x-c++src" = [ "nvim.desktop" ];
  #     "text/x-chdr" = [ "nvim.desktop" ];
  #
  #     # JSON
  #     "application/json" = [ "nvim.desktop" ];
  #     "text/json" = [ "nvim.desktop" ];
  #
  #     # Lua
  #     "text/x-lua" = [ "nvim.desktop" ];
  #     "application/x-lua" = [ "nvim.desktop" ];
  #
  #     # Python
  #     "text/x-python" = [ "nvim.desktop" ];
  #     "application/x-python-code" = [ "nvim.desktop" ];
  #
  #     # Rust
  #     "text/rust" = [ "nvim.desktop" ];
  #     "text/x-rust" = [ "nvim.desktop" ];
  #
  #     # Web / Scripting
  #     "application/javascript" = [ "nvim.desktop" ];
  #     "text/javascript" = [ "nvim.desktop" ];
  #     "text/x-shellscript" = [ "nvim.desktop" ];
  #     "application/x-shellscript" = [ "nvim.desktop" ];
  #     "application/toml" = [ "nvim.desktop" ];
  #     "application/x-yaml" = [ "nvim.desktop" ];
  #     "text/markdown" = [ "nvim.desktop" ];
  #
  #     # --- Video (VLC Flatpak) ---
  #     "video/mp4" = [ "org.videolan.VLC.desktop" ];
  #     "video/x-matroska" = [ "org.videolan.VLC.desktop" ]; # .mkv
  #     "video/webm" = [ "org.videolan.VLC.desktop" ];
  #     "video/quicktime" = [ "org.videolan.VLC.desktop" ]; # .mov
  #     "video/mpeg" = [ "org.videolan.VLC.desktop" ];
  #     "video/x-msvideo" = [ "org.videolan.VLC.desktop" ]; # .avi
  #     "video/x-flv" = [ "org.videolan.VLC.desktop" ];
  #
  #     # --- Audio (VLC Flatpak - Optional) ---
  #     "audio/mpeg" = [ "org.videolan.VLC.desktop" ]; # .mp3
  #     "audio/flac" = [ "org.videolan.VLC.desktop" ];
  #     "audio/x-wav" = [ "org.videolan.VLC.desktop" ];
  #     "audio/mp4" = [ "org.videolan.VLC.desktop" ];
  #
  #     # --- Directories (Yazi) ---
  #     "inode/directory" = [ "yazi.desktop" ];
  #   };
  # };
  #
  
  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  home.enableNixpkgsReleaseCheck = false;
}

