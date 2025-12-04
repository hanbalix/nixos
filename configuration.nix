
{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  services.noctalia-shell.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  networking.hostName = "nix";
  networking.networkmanager.enable = true;
  
  # for noctalia-shell
  hardware.bluetooth.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;


  time.timeZone = "America/Chicago";
  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
   enable = true;
   pulse.enable = true;
   };

  # Enable touchpad support (enabled default in most desktopManager).
   services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.x = {
   isNormalUser = true;
   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
   packages = with pkgs; [
   tree
   ];
   };

  services.xserver = {
      enable = true;
      autoRepeatDelay = 200;
      autoRepeatInterval = 35;
 };
 services.displayManager.ly.enable = true;
  programs.niri.enable = true;
  programs.firefox.enable = true;
  services.flatpak.enable = true;
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
   vim 
   git
   wget
   alacritty
   ghostty
   fuzzel
   brave
   zsh
   zoxide
   starship
   htop
   fd
   bat
   eza
   tmux
   yazi
   fastfetch
   kanata
   ];

   fonts.packages = with pkgs; [
       nerd-fonts.jetbrains-mono
   ];

   nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11"; 

}

