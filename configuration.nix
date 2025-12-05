{ config, lib, pkgs, self, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
#      ./config/xdg/xdg.nix
      #  inputs.home-manager.nixosModules.default
      #
      # xdg.nig from my config clone folder etc
      #
    ];

security.polkit.enable = true;
programs.dconf.enable = true;

  #i had this before
  #services.noctalia-shell.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  # supportedFilesystems = [ "btrfs" ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos";
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
   alsa.enable = true;
   alsa.support32Bit =true;
   };

  # Enable touchpad support (enabled default in most desktopManager).
   services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.x = {
   isNormalUser = true;
   extraGroups = [
     "wheel"
     "networkmanager"
     "plugdev"
     "i2c"
     "video"
     "input"
   ]; # Enable ‘sudo’ for the user.
   packages = with pkgs; [
   tree
   ];
   };

 #  home-manager = {
      # useGlobalPkgs = true;
     #  useUserPackages = true;
   #    extraSpecialArgs = { inherit inputs; };
    #   users = {
  #       "x" = import ./home.nix; -- input my config folder
  #    };
  #   };
  #keyboard repeater
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
   papirus-icon-theme
   ghostty
   fuzzel
   kanata
   pavucontrol #pulseaudio volume control
   pulseaudio
   #networkmanagerapplet #waybar networking control
   swaybg
   gnome-themes-extra
   nodePackages.prettier #makes code prettier
   xwayland
   playerctl
   nix-your-shell # allows 'nix develop to stay in user shell
   nh #nix clip helper
   alejandra # nix code formatter
   ddcutil
   localsend
   polkit_gnome
   networkmanagerapplet
];

   #    description = "chris";
 #   the guy put both of these under his user wheel
 #  shell = pkgs.nushell;
  # environment.systemPackages = [
   #  pkgs.zsh
  # ];
   programs.zsh.enable = true;
#dbus threw errors
   # dbus.enable = true;
   # dbus.packages = with pkgs; [ bluez ];

   # power-profiles-daemon.enable = true;
   # printing.enable = true;
   # gvfs.enable = true;
   services.tumbler.enable = true;

   #for bluetooth
   # hardware.bluetooth = {
   #   enable = true;
   #   package = pkgs.bluez;
   #   input.General.ClassicBondedOnly = false;
   # };
   #
   # environment.systemPackages = with pkgs; [
   #   bluez
   # ];

   fonts.packages = with pkgs; [
       nerd-fonts.jetbrains-mono
       fira-sans
       roboto
       noto-fonts
       noto-fonts-color-emoji
       material-symbols
       material-icons
   ];

   #disables user level packages in homemanager, uses global
   home-manager.useGlobalPkgs = true;
   nix.settings.experimental-features = [ "nix-command" "flakes" ];
  #garbage collecting
   nix.gc = {
     automatic = true;
     dates = "daily";
     options = "--delete-older-than 5d";
   };
  # networkmanager = {
   #  wifi.backend = "wpa_supplicant";
   #  wifi.powersave = false;
   #  };
   # };

   #hardware.enableRedstributableFirmware = true;

   system.stateVersion = "25.11";

}
