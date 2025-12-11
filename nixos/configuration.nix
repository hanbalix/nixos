{ config, lib, pkgs, self, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./t14/hardware-configuration.nix
    # ./config/xdg/xdg.nix
    ../home-manager/config/xdg/xdg.nix
    ../modules/nixos/vm.nix
    ../modules/nixos/keyd.nix
    # ../modules/nixos/audio.nix
  ];

# programs.xss-lock = {enable = true;};
  # Enable Nix flakes and nix-command experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # System version for state management
  system.stateVersion = "25.11";

  # Systemd-boot: modern, simple EFI bootloader
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.grub = {
    enable = lib.mkForce true;
    device = "nodev";
    efiSupport = true;
    # useOSProber = true; for dual booting
    };

  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot";
    };
  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.enableRedistributableFirmware = true;
  #for openGL 
  hardware.graphics.enable = true;
  security.polkit.enable = true;
  programs.dconf.enable = true;


  # services.xserver = {
  #   enable = true;
  #   autoRepeatDelay = 200;  # Delay before key repeat starts (ms)
  #   autoRepeatInterval = 35; # Interval between repeats (ms)
  # };

  # Libinput: touchpad and input device support
  services.libinput.enable = true;

  # Set hostname
  networking.hostName = "nix";

  networking.networkmanager.enable = true;

  time.timeZone = "America/Chicago";
    
  programs.zsh.enable = true;
  
    hardware.bluetooth.enable = false;
    services.printing.enable =  false;
    #for noctalia i have 2 options for pwr profiles
    # services.power-profiles-daemon.enable = true;
    services.tuned.enable = true;
  # UPower: battery and power supply monitoring
    services.upower.enable = true;

    services.displayManager.ly.enable = true;
    programs.niri.enable = true;

    services.flatpak.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono  
    fira-sans                  
    roboto                      
    noto-fonts                  
    noto-fonts-color-emoji   
    material-symbols
    material-icons
  ];



  environment.systemPackages = with pkgs; [
    vim                        
    git                         
    wget

];



  users.users.x = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"           # Sudoers group (can use sudo)
      "networkmanager"  # Manage network connections
      "video"           # Access GPU and display
      "keyd"            # Use keyd keyboard remapping daemon
    ];
  };

  nix.gc = {
    automatic = true;               
    dates = "weekly"; 
    options = "--delete-older-than 30d"; 
  };


}

