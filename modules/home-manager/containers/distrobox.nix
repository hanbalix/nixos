{ config, pkgs, ... }:

{
  programs.distrobox.enable = true;

  services.podman = {
    enable = true;
    autoUpdate.enable = true;
  };

  home.packages = with pkgs; [
    distrobox
    podman
    podman-compose
  ];
}


