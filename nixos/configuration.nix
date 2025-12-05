{ config, lib, pkgs, self, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./t14/hardware-configuration.nix
    # ./config/xdg/xdg.nix
  ];

  # ============================================================================
  # UNIVERSAL / CORE SETTINGS
  # ============================================================================

  # Enable Nix flakes and nix-command experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # System version for state management
  system.stateVersion = "25.11";

  # ============================================================================
  # SECURITY & PERMISSIONS
  # ============================================================================

  # Enable PolicyKit for privilege escalation (needed by many services)
  security.polkit.enable = true;

  # Enable dconf (GNOME settings daemon, used by many GTK applications)
  programs.dconf.enable = true;

  # ============================================================================
  # BOOT & BOOTLOADER
  # ============================================================================

  # Systemd-boot: modern, simple EFI bootloader
  boot.loader.systemd-boot.enable = true;

  # Allow modifying EFI variables (needed for systemd-boot)
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest Linux kernel for latest hardware support and security patches
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # ============================================================================
  # KEYBOARD & INPUT DEVICES
  # ============================================================================

  # Keyd: remap keyboard keys (capslock as control, oneshot modifiers, etc.)
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          shift = "oneshot(shift)";
          meta = "oneshot(meta)";
          control = "oneshot(control)";
          leftalt = "oneshot(alt)";
          rightalt = "oneshot(altgr)";
          capslock = "overload(control, esc)"; # Caps Lock as Escape when pressed, Control when held
          insert = "S-insert";
        };
      };
    };
  };

  # X Server keyboard repeat settings (how fast keys repeat when held)
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;  # Delay before key repeat starts (ms)
    autoRepeatInterval = 35; # Interval between repeats (ms)
  };

  # Libinput: touchpad and input device support
  services.libinput.enable = true;

  # ============================================================================
  # NETWORKING
  # ============================================================================

  # Set hostname
  networking.hostName = "nix";

  # NetworkManager: simple network connection management
  networking.networkmanager.enable = true;

  # ============================================================================
  # TIME & TIMEZONE
  # ============================================================================

  time.timeZone = "America/Chicago";

  # ============================================================================
  # AUDIO & SOUND
  # ============================================================================

  # Pipewire: modern audio server (replaces PulseAudio)
  services.pipewire = {
    enable = true;
    pulse.enable = true;      # PulseAudio compatibility layer
    alsa.enable = true;       # ALSA support
    alsa.support32Bit = true; # 32-bit ALSA support (for older apps)
  };

  # PulseAudio: kept for compatibility with some apps
  # services.pulseaudio.enable = true;

  # ============================================================================
  # POWER MANAGEMENT & HARDWARE
  # ============================================================================

  # Bluetooth support (needed for wireless peripherals)
  hardware.bluetooth.enable = true;

  # Power Profiles Daemon: manage CPU power profiles and thermal management
  services.power-profiles-daemon.enable = true;

  # UPower: battery and power supply monitoring
  services.upower.enable = true;

  # ============================================================================
  # DISPLAY SERVER & WINDOW MANAGER
  # ============================================================================

  # Ly: simple TUI login manager (instead of GDM or SDDM)
  services.displayManager.ly.enable = true;

  # Niri: wayland compositor/window manager
  programs.niri.enable = true;

  # XWayland: run X11 apps under Wayland (compatibility layer)
  environment.systemPackages = [ pkgs.xwayland ];

  # ============================================================================
  # DESKTOP ENVIRONMENT & APPLICATIONS
  # ============================================================================

  # Firefox: web browser
  programs.firefox.enable = true;

  # Flatpak: sandbox container app format
  services.flatpak.enable = true;

  # Zsh: shell configuration
  programs.zsh.enable = true;

  # ============================================================================
  # FILE MANAGEMENT & THUMBNAILS
  # ============================================================================

  # Tumbler: thumbnail generation for file managers
  services.tumbler.enable = true;

  # ============================================================================
  # FONTS
  # ============================================================================

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono  # Monospace font with Nerd Font icons
    fira-sans                   # Sans-serif font
    roboto                      # Modern sans-serif
    noto-fonts                  # Unicode coverage font
    noto-fonts-color-emoji      # Color emoji support
    material-symbols            # Google Material Design symbols
    material-icons              # Google Material Design icons
  ];

  # ============================================================================
  # SYSTEM PACKAGES
  # ============================================================================

  environment.systemPackages = with pkgs; [
    # Essential tools
    vim                         # Text editor
    git                         # Version control
    wget                        # Download files
    pkgs.unzip                  # Archive extraction

    # Terminals
    alacritty                   # GPU-accelerated terminal
    ghostty                     # Fast terminal emulator

    # File managers
    kdePackages.dolphin         # KDE file manager (feature-rich)

    # Window manager / Display tools
    fuzzel                      # Wayland app launcher (rofi alternative)
    swaybg                      # Wayland background setter
    swaylock                    # Wayland screen locker

    # Display configuration
    ddcutil                     # DDC-CI monitor control (brightness, color)
    kdePackages.qt6ct           # Qt6 theme/style settings
    pkgs.libsForQt5.qt5ct       # Qt5 theme/style settings
    kdePackages.breeze          # Breeze KDE theme
    kdePackages.breeze-gtk      # Breeze GTK theme (for consistency)
    kdePackages.systemsettings  # KDE system settings

    # Audio
    pavucontrol                 # PulseAudio volume control GUI
    pulseaudio                  # PulseAudio (kept for compatibility)
    playerctl                   # Media player control (pause, play, next)

    # Security & Notification
    polkit_gnome                # PolicyKit authorization dialog (GTK)
    networkmanagerapplet        # NetworkManager system tray icon

    # Development & Nix tools
    nix-your-shell              # Make 'nix develop' stay in your shell
    nh                          # Nix helper - cleaner NixOS interface
    alejandra                   # Nix code formatter
    nodePackages.prettier       # Code formatter (JavaScript, CSS, etc.)

    # Utilities
    tree                        # Directory tree printer
    localsend                   # LAN file sharing (Airdrop-like)
  ];

  # ============================================================================
  # USER ACCOUNTS
  # ============================================================================

  users.users.x = {
    isNormalUser = true;
    # Groups determine what the user can do
    extraGroups = [
      "wheel"           # Sudoers group (can use sudo)
      "networkmanager"  # Manage network connections
      "plugdev"         # Access USB devices
      "i2c"             # Access I2C devices (display backlight, etc.)
      "video"           # Access GPU and display
      "input"           # Access input devices
      "keyd"            # Use keyd keyboard remapping daemon
    ];
    packages = with pkgs; [
      tree              # Utility for user to use
    ];
  };

  # ============================================================================
  # GARBAGE COLLECTION & SYSTEM CLEANUP
  # ============================================================================

  # Automatic cleanup of old Nix generations
  nix.gc = {
    automatic = true;               # Enable automatic cleanup
    dates = "weekly";               # Run weekly
    options = "--delete-older-than 30d"; # Keep last 30 days of generations
  };

  # ============================================================================
  # DISABLED / COMMENTED OPTIONS
  # ============================================================================

  # Uncomment if you want to use PulseAudio instead of PipeWire:
  # services.pulseaudio.enable = true;

  # Uncomment if you want to use WPA supplicant for WiFi:
  # networkmanager = {
  #   wifi.backend = "wpa_supplicant";
  #   wifi.powersave = false;
  # };

  # Uncomment if you need proprietary firmware:
  # hardware.enableRedistributableFirmware = true;

  # Uncomment if using Home Manager at system level (usually not needed):
  # home-manager.useGlobalPkgs = true;
}

