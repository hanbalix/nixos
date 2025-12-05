{ config, lib, pkgs, self, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./t14/hardware-configuration.nix
    # ./config/xdg/xdg.nix
  ];


  # Enable Nix flakes and nix-command experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # System version for state management
  system.stateVersion = "25.11";

  # SECURITY & PERMISSIONS

  # Enable PolicyKit for privilege escalation (needed by many services)
  security.polkit.enable = true;

  # Enable dconf (GNOME settings daemon, used by many GTK applications)
  programs.dconf.enable = true;


  # Systemd-boot: modern, simple EFI bootloader
  boot.loader.systemd-boot.enable = true;

  # Allow modifying EFI variables (needed for systemd-boot)
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest Linux kernel for latest hardware support and security patches
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # KEYBOARD & INPUT DEVICES

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


  # Set hostname
  networking.hostName = "nix";

  # NetworkManager: simple network connection management
  networking.networkmanager.enable = true;


  time.timeZone = "America/Chicago";

  # AUDIO & SOUND

  # Pipewire: modern audio server (replaces PulseAudio)
  services.pipewire = {
    enable = true;
    pulse.enable = true;      # PulseAudio compatibility layer
    alsa.enable = true;       # ALSA support
    alsa.support32Bit = true; # 32-bit ALSA support (for older apps)
  };

  # PulseAudio: kept for compatibility with some apps
  # services.pulseaudio.enable = true;

  # POWER MANAGEMENT & HARDWARE

  # Bluetooth support (needed for wireless peripherals)
  hardware.bluetooth.enable = true;

  # Power Profiles Daemon: manage CPU power profiles and thermal management
  services.power-profiles-daemon.enable = true;

  # UPower: battery and power supply monitoring
  services.upower.enable = true;

  # DISPLAY SERVER & WINDOW MANAGER

  # Ly: simple TUI login manager (instead of GDM or SDDM)
  services.displayManager.ly.enable = true;

  # Niri: wayland compositor/window manager
  programs.niri.enable = true;


  # Flatpak: sandbox container app format
  services.flatpak.enable = true;


  # Tumbler: thumbnail generation for file managers
  services.tumbler.enable = true;


  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono  # Monospace font with Nerd Font icons
    fira-sans                   # Sans-serif font
    roboto                      # Modern sans-serif
    noto-fonts                  # Unicode coverage font
    noto-fonts-color-emoji      # Color emoji support
    material-symbols            # Google Material Design symbols
    material-icons              # Google Material Design icons
  ];

  environment.systemPackages = with pkgs; [
    # Essential tools
    vim                         # Text editor
    git                         # Version control
    wget                        # Download files
  ];


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


  # Automatic cleanup of old Nix generations
  nix.gc = {
    automatic = true;               # Enable automatic cleanup
    dates = "weekly";               # Run weekly
    options = "--delete-older-than 30d"; # Keep last 30 days of generations
  };


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

