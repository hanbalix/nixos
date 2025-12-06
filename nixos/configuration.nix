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

  # Systemd-boot: modern, simple EFI bootloader
  boot.loader.systemd-boot.enable = true;
    security.polkit.enable = true;
    programs.dconf.enable = true;
  # Allow modifying EFI variables (needed for systemd-boot)
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.enableRedistributableFirmware = true;

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
          capslock = "overload(control, esc)"; 
          insert = "S-insert";
        };
      };
    };
  };

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


  # Pipewire: modern audio server (replaces PulseAudio)
  services.pipewire = {
    enable = true;
    pulse.enable = true;      # PulseAudio compatibility layer
    alsa.enable = true;       # ALSA support
    alsa.support32Bit = true; # 32-bit ALSA support (for older apps)
  };

    hardware.bluetooth.enable = false;
    services.printing.enable =  false;
    services.power-profiles-daemon.enable = true;

  # UPower: battery and power supply monitoring
    services.upower.enable = true;

    services.displayManager.ly.enable = true;
    programs.niri.enable = true;

  # Flatpak: sandbox container app format
    services.flatpak.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono  
    fira-sans                  
    roboto                      
    noto-fonts                  
    noto-fonts-color-emoji   
    material-symbols
    material-icons
    polykit_gnome
  ];

  environment.systemPackages = with pkgs; [
    vim                        
    git                         
    wget                        
];



  users.users.x = {
    isNormalUser = true;
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
      tree              
    ];
  };


  nix.gc = {
    automatic = true;               
    dates = "weekly"; 
    options = "--delete-older-than 30d"; 
  };


}

