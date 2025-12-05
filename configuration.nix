{ config, lib, pkgs, self, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
#      ./config/xdg/xdg.nix
    ];

security.polkit.enable = true;
programs.dconf.enable = true;


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
   services.pipewire = {
   enable = true;
   pulse.enable = true;
   alsa.enable = true;
   alsa.support32Bit =true;
   };

  # Enable touchpad support (enabled default in most desktopManager).
   services.libinput.enable = true;

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


  environment.systemPackages = with pkgs; [
   vim
   git
   wget
   alacritty
   papirus-icon-theme
   ghostty
   kdePackages.dolphin
   fuzzel
   kanata
   pavucontrol #pulseaudio volume control
   pulseaudio
   swaybg
   swaylock
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

   programs.zsh.enable = true;

   # power-profiles-daemon.enable = true;
   services.tumbler.enable = true;


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
